const express = require("express");
const router = express.Router();
const AudienciaService = require("../services/audienciasService.js");

// Obtener todas las audiencias
router.get("/", async (req, res) => {
  try {
    const audiencias = await AudienciaService.listarAudiencias({});
    res.json(audiencias);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Crear una audiencia
router.post("/", async (req, res) => {
  try {
    const audiencia = await AudienciaService.crearAudiencia(req.body);
    res.json(audiencia);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Actualizar una audiencia
router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const audiencia = await AudienciaService.actualizarAudiencia({ id, ...req.body });
    res.json(audiencia);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Obtener una audiencia por ID
router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const audiencia = await AudienciaService.obtenerAudiencia(id);
    res.json(audiencia);
  } catch (err) {
    res.status(404).json({ error: err.message });
  }
});

module.exports = router;
