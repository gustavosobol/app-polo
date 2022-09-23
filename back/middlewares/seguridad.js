require("dotenv").config();
const jwt = require("jsonwebtoken");
const axios = require("../configuraciones/axios");
const storage = require("sessionstorage");

let generateAccessToken = (username) => {
  return jwt.sign({ usuario: username }, process.env.JWT_SECRET, {
    expiresIn: 3600,
  });
};

let removeAccessToken = (req, res) => {
  console.log(`antes del token`);
  let verifyToken = checkToken(req, res);
  console.log(`verifico token ${JSON.stringify(verifyToken.usuario.id)}`);
  const tokenUpdate = `{ "token": ""  }`;
  return axios
    .patch(
      `Usuarios?id=eq.${verifyToken.usuario.id}`,
      JSON.parse(tokenUpdate),
      {
        headers: {
          accept: "application/json",
        },
      }
    )
    .then((response) => {
      res.status(200).json(response.data);
    })
    .catch((error) => {
      return error;
    });
};

const checkToken = (req, res) => {
  if (
    req.headers.authorization === "undefined" ||
    req.headers.authorization === "null" ||
    req.headers.authorization === undefined
  ) {
    if (storage.getItem("jwt") === undefined) {
      // Verifica y devuelve un 401 que no hay ningun token
      // habilitado
      return res.status(401).send({
        message: "Unable to find data",
        status: 401,
      });
    } else {
      // hay que resolver y ver unicamente los casos que necesita el token
      // desde el back ya que cualquiera puede acceder si la pagina tiene un token
      req.headers.authorization = storage.getItem("jwt");
      tokenIngress = req.headers.authorization;
    }
  } else {
    // asigno token a variable
    tokenIngress = req.headers.authorization;
  } // || varUsuario.token;
  const token = tokenIngress.replace("Bearer ", "");

  if (token === "") return res.json("Error token vacio");

  return jwt.verify(token, process.env.JWT_SECRET, function (err, decoded) {
    if (err) {
      if (err === "TokenExpiredError: jwt expired") {
        // si el token ha espirado lo desloguea
        res.status(301).redirect("/logout");
      } else {
        return res.status(401).send({
          message: "Unable to find data",
          errors: err,
          status: 401,
        });
      }
    } else {
      return decoded;
    }
  });
};

module.exports = { generateAccessToken, removeAccessToken };
