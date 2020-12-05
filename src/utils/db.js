const connection = require('../db');

function clearTable(conn, tableName, id) {
  const newName = `${tableName}_${id}`;
  let isTableExist = false;
  return conn
    .query(`CHECK TABLE ${newName}`)
    .then(([status]) => {
      console.log(`CHECK STATUS:`, status);
      if (status[0].Msg_text === 'OK') {
        conn.query(`DELETE FROM ${newName}`);
        isTableExist = true;
      } else {
        conn.query(`CREATE TABLE std_1313.${newName} AS SELECT * FROM ${tableName}`);
      }
    })
    .then(() => {
      if(isTableExist) {
        conn.query(`INSERT INTO ${newName} SELECT * FROM ${tableName}`);
      }
    })
    .then(() => {
      console.log(`SUCCESS ${newName} TABLE`);
    })
    .catch((err) => console.log(`ERR ANW: ${err}`));
}

module.exports = {clearTable};
