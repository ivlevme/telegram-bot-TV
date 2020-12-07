const bluebird = require('bluebird');

// const configMosPolytech = {
//   host: 'std-mysql',
//   port: '3306',
//   user: 'std_1313',
//   database: 'std_1313',
//   password: 'drewIvlev',
//   Promise: bluebird,
// }

const config = {
  host: '127.0.0.1',
  port: '3306',
  user: 'root',
  database: 'std_1313',
  password: 'root',
  Promise: bluebird,
};

module.exports = config;
