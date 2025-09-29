const express = require("express");
const router = express.Router();
const CasoService = require("../services/casosService.js");

// Obtener todos los casos
router.get("/", async (req, res) => {
  try {
    const casos = await CasoService.listarCasos({});
    res.json(casos);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Crear un caso
router.post("/", async (req, res) => {
  try {
    const caso = await CasoService.crearCaso(req.body);
    res.json(caso);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Actualizar un caso
router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const caso = await CasoService.actualizarCaso({ id, ...req.body });
    res.json(caso);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Obtener un caso por ID
router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const caso = await CasoService.obtenerCaso(id);
    res.json(caso);
  } catch (err) {
    res.status(404).json({ error: err.message });
  }
});

module.exports = router;
