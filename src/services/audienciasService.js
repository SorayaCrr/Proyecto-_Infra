const { insert, select, update } = require("../bd/mysql");

const AudienciaService = {
  async crearAudiencia(dataAudiencia) {
    const result = await insert("audiencias", dataAudiencia);
    if (result.affectedRows === 1) {
      return { id: result.insertId, ...dataAudiencia };
    } else {
      throw new Error("Error al crear la audiencia");
    }
  },

  async actualizarAudiencia(dataAudiencia) {
    if (!dataAudiencia.id) {
      throw new Error("idAudiencia es requerido para actualizar");
    }
    const result = await update("audiencias", dataAudiencia, ["id"]);
    if (result.affectedRows === 1) {
      return dataAudiencia;
    } else {
      throw new Error("Error al actualizar la audiencia");
    }
  },

  async obtenerAudiencia(idAudiencia) {
    const rows = await select("audiencias", { id: idAudiencia });
    if (rows.length < 1) {
      throw new Error("la audiencia no existe");
    }
    return rows[0];
  },

  async listarAudiencias(filter = {}) {
    return await select("audiencias", filter);
  },
};

module.exports = AudienciaService;
