module.exports = {
  mappingQueryData(sql, data) {
    let sqlQuery = sql;
    Object.entries(data).forEach(([key, value]) => {
      let safeValue = null;

      if (typeof value === "string")
        safeValue = `'${value.replace(/'/g, "''")}'`;

      if (typeof value === "number" || typeof value === "boolean")
        safeValue = value;

      // Si es Array de string
      if (Array.isArray(value) && typeof value[0] === "string")
        safeValue = `(${value
          .map((v) => `'${v.replace(/'/g, "''")}'`)
          .join(",")})`;

      // Si es Array de number
      if (Array.isArray(value) && typeof value[0] === "number")
        safeValue = `(${value.join(",")})`;

      sqlQuery = sqlQuery.replace(new RegExp(`:${key}`, "g"), safeValue);
    });
    return sqlQuery;
  },

  mappingInsertData(tabla, data, omit) {
    let columns = [];
    let values = [];

    Object.entries(data).forEach(([key, value]) => {
      if (omit && omit.includes(key)) return;

      let safeValue = null;

      if (typeof value === "string")
        safeValue = `'${value.replace(/'/g, "''")}'`;

      if (typeof value === "number" || typeof value === "boolean")
        safeValue = value;

      if (safeValue === null || safeValue === undefined) safeValue = "null";

      columns.push(key);
      values.push(safeValue);
    });

    return `insert into ${tabla} (${columns.join(",")}) values (${values.join(",")})`;
  },

  mappingUpdateData(tabla, data, filter) {
    let queryValues = " set ";
    let queryFilter = " where ";

    Object.entries(data).forEach(([key, value]) => {
      if (value !== null && value !== undefined) {
        let safeValue = null;

        if (typeof value === "string")
          safeValue = `'${value.replace(/'/g, "''")}'`;

        if (typeof value === "number" || typeof value === "boolean")
          safeValue = value;

        if (filter.includes(key)) {
          queryFilter += `${key} = ${safeValue} and `;
        } else {
          queryValues += `${key} = ${safeValue},`;
        }
      }
    });

    return `update ${tabla} ${queryValues.slice(0, -1)} ${queryFilter.slice(0, -4)}`;
  },

  mappingSelectData(tabla, data) {
    let queryValues = " where ";

    Object.entries(data).forEach(([key, value]) => {
      if (value !== null && value !== undefined && value !== "") {
        let safeValue = null;

        if (typeof value === "string")
          safeValue = `'${value.replace(/'/g, "''")}'`;

        if (typeof value === "number" || typeof value === "boolean")
          safeValue = value;

        queryValues += `${key} = ${safeValue} and `;
      }
    });

    return `select * from ${tabla} ${queryValues.slice(0, -4)}`;
  },
};
