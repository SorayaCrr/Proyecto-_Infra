const express = require("express");
const router = express.Router();
const ClienteService = require("../services/clientesService.js");

// Obtener todos los clientes
router.get("/", async (req, res) => {
  try {
    const clientes = await ClienteService.listarClientes({});
    res.json(clientes);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Crear un cliente
router.post("/", async (req, res) => {
  try {
    const cliente = await ClienteService.crearCliente(req.body);
    res.json(cliente);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Actualizar un cliente
router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const cliente = await ClienteService.actualizarCliente({ id, ...req.body });
    res.json(cliente);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Obtener un cliente por ID
router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const cliente = await ClienteService.obtenerCliente(id);
    res.json(cliente);
  } catch (err) {
    res.status(404).json({ error: err.message });
  }
});

module.exports = router;
