const { insert, select, update } = require("../bd/mysql");
const {getFechaActual} = require("../support/utils");
const CONSTANTS = require('../support/constants')

const ClienteService = {
  async crearCliente(dataCliente) {
    const fecha_creacion = getFechaActual();
    const estado = CONSTANTS.CLIENTE.ESTADO.ACTIVO
    const result = await insert("clientes", {...dataCliente,estado,fecha_creacion});
    if (result.affectedRows == 1) {
      return { id: result.insertId, ...dataCliente,estado,fecha_creacion }
    } else {
      throw new Error("Error al crear el cliente");
    }
  },

  async actualizarCliente(dataCliente) {
    const fecha_actualizacion = getFechaActual();
    if (!dataCliente.id) {
      throw new Error("idCliente es requerido para actualizar");
    }
    const result = await update("clientes", {...dataCliente,fecha_actualizacion}, ["id"]);
    if (result.affectedRows == 1) {
      return {...dataCliente,fecha_actualizacion};
    } else {
      throw new Error("Error al crear el cliente");
    }
  },

  async obtenerCliente(idCliente) {
    const rows = await select("clientes", { id: idCliente });
    if (rows.length < 1) {
      throw new Error("el cliente no existe");
    }
    return rows[0];
  },

  async listarClientes(filter = {}) {
    return await select("clientes", filter);
  },
};

module.exports = ClienteService;
