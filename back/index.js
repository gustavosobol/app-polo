// para obtener variables desde le archivo env
require("dotenv").config();
// importaciones de modulos externos
const express = require("express");
const helmet = require("helmet");
const cors = require("cors");
// puerto que se va a publicar la app
let port = 4000;
// asigno aplicaciones importadas
const app = express();
app.use(helmet());
app.use(cors());
// sirve para leer los req de json o arrays json
app.use(express.json());

// configuraciones de login
const login = require("./routes/login");
app.use("/", login);

// configuraciones de usuarios
const usuarios = require("./routes/usuarios.js");
app.use("/usuarios", usuarios);

//Inicializo los servidores
app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}/`);
});
