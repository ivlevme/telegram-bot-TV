const TelegramBot = require('node-telegram-bot-api');
const mysql = require('mysql2');

const TOKEN = `1354385957:AAHgE3EWSIa9iWIS5R8DWMONhIBp8uQT5L0`;
const bot = new TelegramBot(TOKEN, {polling: true});

let ID_CHAT = null; //FIXME:
let START_ORDER = 1;

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
    return false;
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
      saveAnswer(msg.text, question.Parameter);

      bot.off('message');
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

  if (value !== 'help') {
    connection.query(`INSERT INTO Answ (Parameter, Value) VALUES (?,?)`, [param, value], function (
      err,
      question
    ) {
      if (err) {
        throw new Error(err);
      }

      console.log(`success saved! ${param} - ${value}`);

      getOrderNextQuestion(param, value);
    });
    return;
  }

  getOrderNextQuestion(param, value);
}

bot.onText(/\/start/, (msg) => {
  ID_CHAT = null;
  START_ORDER = 1;

  bot.sendMessage(msg.chat.id, `Здравствуйте, ${msg.from.first_name}!`);
  ID_CHAT = msg.chat.id;

  getQuestion(START_ORDER, ID_CHAT);
});

bot.on('callback_query', (query) => {
  const [value, param] = query.data.split(',');

  bot.answerCallbackQuery(query.id, `Принято ${value}`);
  saveAnswer(value, param);
});
