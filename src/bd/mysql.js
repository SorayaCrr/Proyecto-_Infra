const db = require("./db");
const { mappingInsertData, mappingSelectData, mappingUpdateData } = require("./mappingUtils.js"); 

module.exports = {
  async insert(tabla, data, omit = []) {
    const sql = mappingInsertData(tabla, data, omit);
    const [result] = await db.query(sql);
    return result;
  },

  async update(tabla, data, filter) {
    const sql = mappingUpdateData(tabla, data, filter);
    const [result] = await db.query(sql);
    return result;
  },

  async select(tabla, filter = {}) {
    const sql = mappingSelectData(tabla, filter);
    const [rows] = await db.query(sql);
    return rows;
  }
};
