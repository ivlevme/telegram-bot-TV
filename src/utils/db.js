const connection = require('../db');

function createAnswerTable(id) {
  const tableName = `Answ_${id}`;
  try {
    connection.query(`CHECK TABLE ${tableName}`, function (err, result) {
      console.log(result);
      if (result[0].Msg_text === 'OK') {
        connection.query(`DELETE FROM ${tableName}`);
        console.log(`DELETE TABLE!!!`);
        return;
      }
      connection.query(
        `CREATE TABLE std_1313.${tableName} (ID INT NOT NULL AUTO_INCREMENT , Parameter VARCHAR(100) NOT NULL , Value VARCHAR(100) NOT NULL , PRIMARY KEY (ID)) ENGINE = InnoDB;
          `
      );
      console.log(`CREATE TABLEE!!`);
    });
  } catch (error) {
    console.log(error);
    connection.query(`DELETE FROM ${tableName}`);
  }

  return tableName;
}

module.exports = createAnswerTable;
