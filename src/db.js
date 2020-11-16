const mysql = require('mysql2');


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


module.exports = connection;