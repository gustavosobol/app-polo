const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const express = require("express");
const router = express.Router();

// configuraciones de axios
const axios = require("../configuraciones/axios");

router.post("/login", function (req, res) {
  console.log(`req login ${JSON.stringify(req.body)}`);

  axios
    .get(`Usuarios?user=like.*${req.body.usuario}*`, {
      headers: {
        accept: "application/json",
      },
    })
    .then((response) => {
      try {
        console.log(
          `req login2 ${JSON.stringify(response.data[0]["password"])}`
        );
        bcrypt
          .compare(req.body.contrasena, response.data[0]["password"])
          .then((result) => {
            console.log(`result ${result}`);
            if (result) {
              reutres.status(200).json(response.data);
            } else {
              res.status(401).json("Error de contraseña");
            }
          });
      } catch (e) {
        console.log(e);
      }
    })
    .catch(function (error) {
      console.log(`error ${error}`);
    });
});

module.exports = router;
