const express = require("express");
const cors = require("cors");

const clientesRoutes = require("./routes/clientes");
const casosRoutes = require("./routes/casos");
const audienciasRoutes = require("./routes/audiencias");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api/clientes", clientesRoutes);
app.use("/api/casos", casosRoutes);
app.use("/api/audiencias", audienciasRoutes);

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
