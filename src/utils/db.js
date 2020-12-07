const connection = require('../db');

async function clearTable(conn, tableName, id) {
  const newName = `${tableName}_${id}`;

  const [status] = await conn.query(`CHECK TABLE ${newName}`);
  console.log(`CHECK STATUS:`, status);

  if (status[0].Msg_text === 'OK') {
    await conn.query(`TRUNCATE TABLE ${newName}`);
    await conn.query(`INSERT INTO ${newName} SELECT * FROM ${tableName}`);
    return;
  }

  await conn.query(`CREATE TABLE std_1313.${newName} AS SELECT * FROM ${tableName}`);
  console.log(`SUCCESS ${newName} TABLE`);
}

module.exports = {clearTable};
