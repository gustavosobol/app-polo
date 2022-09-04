require("dotenv").config();
const express = require("express");
const app = express();
const helmet = require("helmet");
const cors = require("cors");

let port = 4000;
app.use(helmet());
app.use(cors());
// sirve para leer los req de json o arrays json
app.use(express.json());

// configuraciones de usuarios
const usuarios = require("./routes/usuarios.js");
app.use("/usuarios", usuarios);

app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}/`);
});
