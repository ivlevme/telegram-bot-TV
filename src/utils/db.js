const connection = require('../db');

async function clearTable(conn, tableName, id) {
  const newName = `${tableName}_${id}`;
  let isTableExist = false;
  const [status] = await conn.query(`CHECK TABLE ${newName}`);
  console.log(`CHECK STATUS:`, status);
  if (status[0].Msg_text === 'OK') {
    await conn.query(`DELETE FROM ${newName}`);
    isTableExist = true;
  } else {
    await conn.query(`CREATE TABLE std_1313.${newName} AS SELECT * FROM ${tableName}`);
  }
  if (isTableExist) {
    conn.query(`INSERT INTO ${newName} SELECT * FROM ${tableName}`);
  }
  console.log(`SUCCESS ${newName} TABLE`);
}

module.exports = {clearTable};
