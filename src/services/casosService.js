const { insert, select, update } = require("../bd/mysql");
const CONSTANTS = require('../support/constants')

const CasoService = {
  async crearCaso(dataCaso) {
    const estado = CONSTANTS.CASOS.ESTADO.CREADO;
    const result = await insert("casos", {...dataCaso,estado});
    
    if (result.affectedRows === 1) {
      return { id: result.insertId, ...dataCaso, estado };
    } else {
      throw new Error("Error al crear el caso");
    }
  },

  async actualizarCaso(dataCaso) {
    if (!dataCaso.id) {
      throw new Error("id es requerido para actualizar el caso");
    }
    const result = await update("casos", dataCaso, ["id"]);
    if (result.affectedRows === 1) {
      return dataCaso;
    } else {
      throw new Error("Error al actualizar el caso");
    }
  },

  async obtenerCaso(idCaso) {
    const rows = await select("casos", { id: idCaso });
    if (rows.length < 1) {
      throw new Error("el caso no existe");
    }
    return rows[0];
  },

  async listarCasos(filter = {}) {
    return await select("casos", filter);
  },
};

module.exports = CasoService;
