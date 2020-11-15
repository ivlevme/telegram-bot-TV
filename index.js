const TelegramBot = require('node-telegram-bot-api');
const mysql = require('mysql2');

const TOKEN = `1354385957:AAHgE3EWSIa9iWIS5R8DWMONhIBp8uQT5L0`;
const bot = new TelegramBot(TOKEN, {polling: true});

let ID_CHAT = null; //FIXME:
let START_ORDER = 1;
let CURRENT_ANSW_TABLE = '';

const connection = mysql.createConnection({
  host: 'std-mysql',
  port: '3306',
  user: 'std_1313',
  database: 'std_1313',
  password: 'drewIvlev',
});

connection.connect(function (err) {
  if (err) {
    return console.error('Ошибка: ' + err.message);
  } else {
    console.log('Подключение к серверу MySQL успешно установлено');
  }
});

function getOrderNextQuestion(param, value) {
  console.log('order - ', param, value);
  connection.query(
    `SELECT NextQuest FROM QuestRules WHERE IF_Par = ? AND IF_Value = ?`,
    [param, value],
    function (err, questionOrder) {
      if (err) {
        throw new Error(err);
      }

      console.log('Next question - ', questionOrder);
      if (questionOrder.length !== 0) {
        const {NextQuest} = questionOrder[0];
        START_ORDER = NextQuest;
        getQuestion(NextQuest);
        return;
      }

      START_ORDER++;
      getQuestion(START_ORDER);
    }
  );
}

function getQuestion(order, id) {
  connection.query(`SELECT * FROM Quest WHERE OrderQwest = '?'`, [order], function (err, question) {
    if (err) {
      throw new Error(err);
    }

    if (question.length) {
      const [name, keyboard] = generateInterfaceForQuestion(question[0]);

      console.log(name);
      console.log(keyboard);

      bot.sendMessage(ID_CHAT, name, keyboard);
      return true;
    }

    bot.sendMessage(ID_CHAT, 'Отлично! Мы закончили! Вот ваш результат: ');
    sendSelectedItem();

    return false;
  });
}

function sendSelectedItem(params) {
  connection.query(`SELECT * FROM ${CURRENT_ANSW_TABLE}`, function (err, data) {
    if (err) {
      throw new Error(err);
    }

    console.log(data);

    const term = data
      .map((param) => {
        return `${param.Parameter}='${param.Value}'`;
      })
      .join(' AND ');

    console.log(term);

    connection.query(`SELECT * FROM Items WHERE ${term}`, function (err, data) {
      if (err) {
        throw new Error(err);
      }

      const result = data.length
        ? JSON.stringify(data, null, 2)
        : `По вашем параметрам нет подходящих телевизоров. Попробуйте ещё раз командой /start`;
      bot.sendMessage(ID_CHAT, result);
    });
  });
}

function generateInterfaceForQuestion(question) {
  console.log(question);
  let answers = [];

  for (let i = 1; i <= 4; i++) {
    const idx = ['Answer' + i];

    if (question[idx]) {
      const answer = {
        text: question[idx],
        callback_data: `${question[idx]},${question.Parameter}`.trim(),
      };

      answers.push(answer);
    }
  }

  if (answers.length === 0) {
    bot.on('message', (msg) => {
      switch (question.Parameter) {
        case 'diagonal':
          if (msg.text >= 22 && msg.text <= 75) {
            saveAnswer(msg.text, question.Parameter);
            bot.off('message');
          } else {
            bot.sendMessage(ID_CHAT, 'Ваш ответ некорректен, введите данные в диапазоне 22-75');
          }
          break;

        case 'developYear':
          if (msg.text >= 2017 && msg.text <= 2020) {
            saveAnswer(msg.text, question.Parameter);
            bot.off('message');
          } else {
            bot.sendMessage(ID_CHAT, 'Ваш ответ некорректен, введите данные в диапазоне 2017-2020');
          }
          break;
      }
    });
  }

  const inlineKeyboard = [
    question.Question,
    answers.length
      ? {
          reply_markup: {
            inline_keyboard: [answers],
          },
        }
      : {},
  ];

  return inlineKeyboard;
}

function saveAnswer(value, param) {
  console.log(`param: `, param);
  console.log(`save: `, value);

  connection.query(`SELECT ParamValue FROM ParamValue WHERE AnswValue = ?`, [value], function (
    err,
    result
  ) {
    if (err) {
      throw new Error(err);
    }

    console.log(result);

    if (result.length) {
      const {ParamValue} = result[0];
      console.log(ParamValue);

      connection.query(
        `INSERT INTO ${CURRENT_ANSW_TABLE} (Parameter, Value) VALUES (?,?)`,
        [param, ParamValue],
        function (err, question) {
          if (err) {
            throw new Error(err);
          }

          console.log(`success saved! ${ParamValue} - ${value}`);

          getOrderNextQuestion(ParamValue, value);
        }
      );
    } else if (value !== `help`) {
      connection.query(
        `INSERT INTO ${CURRENT_ANSW_TABLE} (Parameter, Value) VALUES (?,?)`,
        [param, value],
        function (err) {
          if (err) {
            throw new Error(err);
          }

          console.log(`success saved! ${param} - ${value}`);

          getOrderNextQuestion(param, value);
        }
      );
    } else {
      getOrderNextQuestion(param, value);
    }
  });
}

function createAnswerTable(id) {
  const tableName = `Answ_${Date.now()}`;
  try {
    connection.query(
      `CREATE TABLE std_1313.${tableName} (ID INT NOT NULL AUTO_INCREMENT , Parameter VARCHAR(100) NOT NULL , Value VARCHAR(100) NOT NULL , PRIMARY KEY (ID)) ENGINE = InnoDB;
      `
  );
  } catch (error) {
    console.log(error)
  }

  return tableName;
}

bot.onText(/\/start/, (msg) => {
  ID_CHAT = null;
  START_ORDER = 1;

  bot.sendMessage(msg.chat.id, `Здравствуйте, ${msg.from.first_name}!`);
  ID_CHAT = msg.chat.id;

  CURRENT_ANSW_TABLE = createAnswerTable(msg.chat.id);

  getQuestion(START_ORDER, ID_CHAT);
});

bot.onText(/\/items/, (msg) => {
  connection.query(`SELECT * FROM Items`, function (err, tvs) {
    if (err) {
      throw new Error(err);
    }

    bot.sendMessage(
      msg.chat.id,
      tvs.length ? JSON.stringify(tvs, null, 2) : `Телевизоры отсутсвуют в БД :( `
    );
  });
});

bot.on('callback_query', (query) => {
  const [value, param] = query.data.split(',');

  bot.answerCallbackQuery(query.id, `Принято ${value}`);
  saveAnswer(value, param);
});
