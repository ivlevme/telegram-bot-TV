const bot = require('./initBot');
const connection = require('./db');

const createAnswerTable = require('./utils/db');

let START_ORDER = 1;
let HELP_WORD = 'help';
let ANSW_TABLE = '';

const OrderState = {};

function getOrderNextQuestion(param, value, id) {
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
        OrderState[ANSW_TABLE] = NextQuest;

        getQuestion(NextQuest, id);
        return;
      }

      OrderState[ANSW_TABLE]++;
      getQuestion(OrderState[ANSW_TABLE], id);
    }
  );
}

function getQuestion(order, msgId) {
  connection.query(`SELECT * FROM Quest WHERE OrderQwest = '?'`, [order], function (err, question) {
    if (err) {
      throw new Error(err);
    }

    if (question.length) {
      const [name, keyboard] = generateInterfaceForQuestion(question[0]);

      console.log(name);
      console.log(keyboard);

      bot.sendMessage(msgId, name, keyboard);
      return;
    }

    bot.sendMessage(msgId, 'Отлично, мы закончили! Сейчас появится результат, ожидайте :)');
    sendSelectedItem(msgId);
  });
}

function sendSelectedItem(id) {
  connection.query(`SELECT * FROM ${ANSW_TABLE}`, function (err, data) {
    if (err) {
      throw new Error(err);
    }

    console.log(data);

    const term = data.map((param) => `${param.Parameter}='${param.Value}'`).join(' AND ');
    console.log(term);

    connection.query(`SELECT * FROM Items WHERE ${term}`, function (err, data) {
      if (err) {
        throw new Error(err);
      }

      const result = data.length
        ? JSON.stringify(data, null, 2)
        : `По вашем параметрам нет подходящих телевизоров. Попробуйте ещё раз командой /start`;
      bot.sendMessage(id, result);
    });
  });
}

function getAnswerOptions(question) {
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

  return answers;
}

function getWrittenAnswer(question) {
  bot.on('message', (msg) => {
    console.log(`MSG!!!!`, msg.chat.id);
    switch (question.Parameter) {
      case 'diagonal':
        if (msg.text >= 22 && msg.text <= 75) {
          console.log(`SAVE ANSW`);
          saveAnswer(msg.text, question.Parameter, msg.chat.id);
          bot.off('message');
        } else {
          bot.sendMessage(msg.chat.id, 'Ваш ответ некорректен, введите данные в диапазоне 22-75');
        }
        break;

      case 'developYear':
        if (msg.text >= 2017 && msg.text <= 2020) {
          saveAnswer(msg.text, question.Parameter, msg.chat.id);
          bot.off('message');
        } else {
          bot.sendMessage(
            msg.chat.id,
            'Ваш ответ некорректен, введите данные в диапазоне 2017-2020'
          );
        }
        break;
    }
  });
}

function generateInterfaceForQuestion(question) {
  let answers = getAnswerOptions(question);
  console.log('ANSWERS', answers);

  if (answers.length === 0) {
    getWrittenAnswer(question);

    return [question.Question, {}];
  }

  const inlineKeyboard = [
    question.Question,
    {
      reply_markup: {
        inline_keyboard: [answers],
      },
    },
  ];

  return inlineKeyboard;
}

function saveCulcParametr(param, result, id) {
  const {ParamValue} = result[0];
  console.log(ParamValue);

  insertParam(param, ParamValue, id);
}

function insertParam(param, value, id) {
  connection.query(
    `INSERT INTO ${ANSW_TABLE} (Parameter, Value) VALUES (?,?)`,
    [param, value],
    function (err) {
      if (err) {
        throw new Error(err);
      }

      console.log(`success saved! ${param} - ${value}`);

      getOrderNextQuestion(param, value, id);
    }
  );
}

function saveAnswer(value, param, id) {
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
    console.log(`RESULT`);

    if (result.length) {
      saveCulcParametr(param, result, id);
    } else if (value !== HELP_WORD) {
      insertParam(param, value, id);
    } else {
      getOrderNextQuestion(param, value, id);
    }
  });
}

bot.onText(/\/start/, (msg) => {
  bot.sendMessage(msg.chat.id, `Здравствуйте, ${msg.from.first_name}!`);
  console.log(msg.chat.id);

  ANSW_TABLE = createAnswerTable(msg.chat.id);
  OrderState[ANSW_TABLE] = START_ORDER;

  getQuestion(OrderState[ANSW_TABLE], msg.chat.id);
});

bot.onText(/\/items/, (msg) => {
  connection.query(`SELECT * FROM Items`, function (err, tvs) {
    if (err) {
      throw new Error(err);
    }

    bot.sendMessage(
      msg.chat.id,
      tvs.length ? JSON.stringify(tvs.slice(0, 15), null, 2) : `Телевизоры отсутсвуют в БД :( `
    );
  });
});

bot.on('callback_query', (query) => {
  const [value, param] = query.data.split(',');

  bot.answerCallbackQuery(query.id, `Принято ${value}`);
  saveAnswer(value, param, query.message.chat.id);
});
