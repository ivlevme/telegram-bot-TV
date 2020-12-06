const worker = require('worker_threads');
const mysql = require('mysql2/promise');
const fs = require('fs');

const bot = require('./initBot');
const config = require('./db');
const {sqlCreatQwestTable, sqlCreateAnswTable} = require('./utils/const');
const {clearTable, clearUsedComplexRules} = require('./utils/db');

const LogicalOperation = ['', `AND`, `OR`, `NOT`];
let START_ORDER = 1;

let connection = null;
const OrderState = {};

async function isParamDefine(param, id) {
  console.log(`PAram - `, param);
  const [result] = await connection.query(`SELECT * FROM Answ_${id} WHERE Parameter = ?`, [param]);
  console.log(`isPARAM DEFINE RESULT ---`, result);
  if (result.length) {
    return true;
  }
  return false;
}

async function defineValueParam(param, id) {
  const [result] = await connection.query(`SELECT Value FROM Answ_${id} WHERE Parameter = ?`, [
    param,
  ]);
  console.log(`isPARAM DEFINE RESULT ---`, result);
  if (result.length) {
    return result[0].Value;
  }
  return '';
}

async function getOrderNextQuestion(param, value, id) {
  console.log('order - ', param, value);
  checkComplexRules(param, value, id);

  const [
    questionOrder,
  ] = await connection.query(`SELECT NextQuest FROM QuestRules WHERE IF_Par = ? AND IF_Value = ?`, [
    param,
    value,
  ]);

  console.log('Next question - ', questionOrder);
  if (questionOrder.length) {
    const {NextQuest} = questionOrder[0];
    OrderState[id] = NextQuest;

    getQuestion(NextQuest, id);
    return;
  }

  OrderState[id]++;
  getQuestion(OrderState[id], id);
}

async function getQuestion(order, msgId) {
  const [question] = await connection.query(`SELECT * FROM Quest_${msgId} WHERE OrderQwest = '?'`, [
    order,
  ]);

  console.log(`Current Question`, question);
  if (question.length) {
    const isParam = await isParamDefine(question[0].Parameter, msgId);

    console.log(`Isn't PARAM DEFINE: -- `, isParam);
    if (!isParam) {
      const [name, keyboard] = generateInterfaceForQuestion(question[0]);

      console.log(name);
      console.log(keyboard);

      bot.sendMessage(msgId, name, keyboard);
    } else {
      console.log(`Определен ПВОТ ОН - `, question[0].Parameter);
      const valueParam = await defineValueParam(question[0].Parameter, msgId);
      console.log(`Определен Значение - `, valueParam);
      getOrderNextQuestion(question[0].Parameter, valueParam, msgId);
    }
    return;
  }

  bot.sendMessage(msgId, 'Отлично, мы закончили! Сейчас появится результат, ожидайте :)');
  sendSelectedItem(msgId);
}

async function sendSelectedItem(id) {
  const [data] = await connection.query(`SELECT * FROM Answ_${id}`);

  const term = data.map((param) => `${param.Parameter}='${param.Value}'`).join(' AND ');
  console.log(term);

  const [suitableItem] = await connection.query(`SELECT * FROM Items WHERE ${term}`);

  if (suitableItem.length) {
    const result = suitableItem[0];
    console.log(result);
    const userResult = `
      Вам подходит следующая модель:
      • Производитель - ${result.Manufacturer}
      • Диагональ экрана - ${result.Diagonal}"
      • Разрешение экрана - ${result.Resolution}
      • Год производства - ${result.DevelopYear}
      • Частота обновления экрана - ${result.Frequency} Гц
      • Тип матрицы - ${result.Illumination}
      • Поддержка смартТВ - ${result.Smarttv}
      • Поддержка блютуз - ${result.Bluetooth}
      • Поддержка интернета - ${result.Network}
      • Поддержка HDR - ${result.Hdr}
      `;
    bot.sendMessage(id, userResult);
    bot.sendPhoto(id, fs.readFileSync(__dirname + '/tv.png'));
    return;
  }

  bot.sendMessage(
    id,
    `По вашем параметрам нет подходящих телевизоров. Попробуйте ещё раз командой /start`
  );
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
    switch (question.Parameter) {
      case 'diagonal':
        if (msg.text == 22 || msg.text == 55 || msg.text == 65) {
          console.log(`SAVE ANSW`);
          saveAnswer(msg.text, question.Parameter, msg.chat.id);
          bot.off('message');
        } else {
          bot.sendMessage(msg.chat.id, 'Ваш ответ некорректен, введите данные: 22, 55 или 65');
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

async function insertParam(param, value, id) {
  await Promise.all([
    connection.query(`INSERT INTO Answ_${id} (Parameter, Value) VALUES (?,?)`, [param, value]),
    connection.query(`UPDATE Quest_${id} SET Asked = ? WHERE OrderQwest = ${OrderState[id]}`, [1]),
  ]);

  console.log(`success saved! ${param} - ${value}`);
  getOrderNextQuestion(param, value, id);
}

function compareAtrValue(answers, atr, value) {
  for (const answer of answers) {
    if (answer.Parameter == atr) {
      if (answer.Value == value) {
        return true;
      }
    }
  }
  return false;
}

async function checkComplexRules(param, value, id) {
  const [allUserAnswers] = await connection.query(`SELECT * FROM Answ_${id}`);
  const [allComplexRules] = await connection.query(`SELECT * FROM RulesComplex_${id} WHERE Used = 0`);

  if (allUserAnswers.length) {
    allComplexRules.forEach(async (rule) => {
      if (
        compareAtrValue(allUserAnswers, rule.IF1_Atr, rule.IF1_Value) &&
        compareAtrValue(allUserAnswers, rule.IF2_Atr, rule.IF2_Value)
      ) {
        console.log(`RULE WAS FOUND SUCCESS!`, rule);
        await connection.query(`INSERT INTO Answ_${id} (Parameter, Value) VALUES (?,?)`, [
          rule.Then_Atr,
          rule.Then_Value,
        ]);
        await connection.query(`UPDATE RulesComplex_${id} SET Used = 1 WHERE ID = ?`, [rule.ID]);
      }
    });
  }
}

async function saveAnswer(value, param, id) {
  console.log(`param: `, param);
  console.log(`save: `, value);

  const [
    result,
  ] = await connection.query(
    `SELECT Then_Atr, Then_Value FROM RulesSimple WHERE 	IF_Atr = ? AND IF_Value = ?`,
    [param, value]
  );
  console.log(`RESULT: `, result);
  if (result.length) {
    const {Then_Atr: atr, Then_Value: atrValue} = result[0];
    console.log(`atr - `, atr);
    console.log(`atrValue - `, atrValue);
    console.log(`save asnw funct`);
    console.log(typeof atr);
    if (atr !== null && atrValue !== null) {
      insertParam(atr, atrValue, id);
    } else {
      getOrderNextQuestion(param, value, id);
    }
    return;
  }
  insertParam(param, value, id);
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

      Promise.all([
        clearTable(conn, `Answ`, msg.chat.id),
        clearTable(conn, `Quest`, msg.chat.id),
        clearTable(conn, `RulesComplex`, msg.chat.id),
      ])
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
  mysql.createConnection(config).then((conn) => {
    conn
      .query(`SELECT * FROM Items`)
      .then(([tvs]) => {
        bot.sendMessage(
          msg.chat.id,
          tvs.length ? JSON.stringify(tvs.slice(0, 10), null, 2) : `Телевизоры отсутсвуют в БД :( `
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

  bot.deleteMessage(query.message.chat.id, query.message.message_id);
  bot.sendMessage(query.message.chat.id, `${query.message.text}: ${value}`, {
    disable_notification: true,
  });

  bot.answerCallbackQuery(query.id, `Принято ${value}`);
  saveAnswer(value, param, query.message.chat.id);
});
