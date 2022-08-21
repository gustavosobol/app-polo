require("dotenv").config();
const express = require("express");
const app = express();
const helmet = require("helmet");
const cors = require("cors");

let port = 4000;
app.use(helmet());
app.use(cors());

app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}/api-docs`);
});
