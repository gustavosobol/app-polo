// para obtener variables desde le archivo env
require("dotenv").config();
// importaciones de modulos externos
const express = require("express");
const helmet = require("helmet");
const cors = require("cors");
// puerto que se va a publicar la app
let port = process.env.PORT || 4000;
// importo y cargo passport
const passportGoogle = require("./configuraciones/passport-google");
// asigno aplicaciones importadas
const app = express();
app.use(helmet());
app.use(cors());
// sirve para leer los req de json o arrays json
app.use(express.json());
// importacion de middlewes
const midSeguridad = require("./middlewares/seguridad");
// configuraciones de login
const login = require("./routes/login");
app.use("/", login);

// configuraciones de usuarios
const usuarios = require("./routes/usuarios.js");
app.use("/usuarios", [midSeguridad.userLog], usuarios);

// configuraciones de alumnos
const alumnos = require("./routes/alumnos.js");
app.use("/alumnos", alumnos);

// configuraciones de localidad
const localidad = require("./routes/localidad.js");
app.use("/localidad", localidad);

//Inicializo los servidores
app.listen(port, () => {
  console.log(`Servidor corriendo en http://${process.env.HOST}:${port}/`);
});
