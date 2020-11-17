const worker = require('worker_threads');
const mysql = require('mysql2/promise');
const fs = require('fs');

const bot = require('./initBot');
const config = require('./db');
const {sqlCreatQwestTable, sqlCreateAnswTable} = require('./utils/const');

const {clearTable} = require('./utils/db');

let START_ORDER = 1;
let HELP_WORD = 'help';

const OrderState = {};

let connection = null;

function getOrderNextQuestion(param, value, id) {
  console.log('order - ', param, value);

  connection
    .query(`SELECT NextQuest FROM QuestRules WHERE IF_Par = ? AND IF_Value = ?`, [param, value])
    .then(([questionOrder]) => {
      console.log('Next question - ', questionOrder);
      if (questionOrder.length !== 0) {
        const {NextQuest} = questionOrder[0];
        OrderState[id] = NextQuest;

        getQuestion(NextQuest, id);
        return;
      }

      OrderState[id]++;
      getQuestion(OrderState[id], id);
    });
}

function getQuestion(order, msgId) {
  connection
    .query(`SELECT * FROM Quest_${msgId} WHERE OrderQwest = '?'`, [order])
    .then(([question]) => {
      console.log(question);
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
  connection.query(`SELECT * FROM Answ_${id}`).then(([data]) => {
    const term = data.map((param) => `${param.Parameter}='${param.Value}'`).join(' AND ');
    console.log(term);

    connection.query(`SELECT * FROM Items WHERE ${term}`).then(([data]) => {
      if (data.length) {
        bot.sendMessage(id, JSON.stringify(data, null, 2));
        bot.sendPhoto(id, fs.readFileSync(__dirname + '/tv.png'));
        return;
      }

      bot.sendMessage(id, `По вашем параметрам нет подходящих телевизоров. Попробуйте ещё раз командой /start`);
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
        one_time_keyboard: true,
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
  Promise.all([
    connection.query(`INSERT INTO Answ_${id} (Parameter, Value) VALUES (?,?)`, [param, value]),
    connection.query(`UPDATE Quest_${id} SET Asked = ? WHERE OrderQwest = ${OrderState[id]}`, [1]),
  ]).then(() => {
    console.log(`success saved! ${param} - ${value}`);
    getOrderNextQuestion(param, value, id);
  });
}

function saveAnswer(value, param, id) {
  console.log(`param: `, param);
  console.log(`save: `, value);

  connection
    .query(`SELECT ParamValue FROM ParamValue WHERE AnswValue = ?`, [value])
    .then(([result]) => {
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

  OrderState[msg.chat.id] = START_ORDER;

  mysql
    .createConnection(config)
    .then((conn) => {
      connection = conn;

      console.log(`SUCCESS CONNETED TO DATABASE`);
      bot.sendMessage(msg.chat.id, `Соединение с БД успешно установлено!`);

      Promise.all([clearTable(conn, `Answ`, msg.chat.id), clearTable(conn, `Quest`, msg.chat.id)])
        .then(() => {
          console.log(`SUCCESS CREATE ANSW AND COPY QUEST TABLES`);

          console.log(' get QWEST ', OrderState[msg.chat.id]);
          getQuestion(OrderState[msg.chat.id], msg.chat.id);
        })
        .catch((err) => {
          console.error(`ERROR: `, err);
          bot.sendMessage(msg.chat.id, `Не удалось сессию. Попруйте ещё раз /start`);
        });
    })
    .catch((err) => {
      console.error(`ERROR: ${err}`);
      bot.sendMessage(msg.chat.id, `Не удалось подключиться к БД. Попробуйте ещё раз /start`);
    });
});

bot.onText(/\/items/, (msg) => {
  mysql
    .createConnection(config)
    .then((conn) => {
    conn
    .query(`SELECT * FROM Items`)
    .then(([tvs]) => {
      bot.sendMessage(
        msg.chat.id,
        tvs.length ? JSON.stringify(tvs.slice(0, 15), null, 2) : `Телевизоры отсутсвуют в БД :( `
      );
    })
    .catch((err) => {
      bot.sendMessage(msg.chat.id, 'Извините, БД не работает :(');
      throw new Error(err);
    });
  });
});

bot.on('callback_query', (query) => {
  const [value, param] = query.data.split(',');

  bot.deleteMessage(query.message.chat.id, query.message.message_id)
  bot.sendMessage(query.message.chat.id, `${query.message.text}: ${value}`, {
    disable_notification: true
  })

  bot.answerCallbackQuery(query.id, `Принято ${value}`);
  saveAnswer(value, param, query.message.chat.id);
});
