require("dotenv").config();
const seguridad = require("../middlewares/seguridad");
const bcrypt = require("bcrypt");
const express = require("express");
const router = express.Router();
const passport = require("passport");
const storage = require("sessionstorage");
// configuraciones de axios
const axios = require("../configuraciones/axios");

router.post("/login", function (req, res) {
  axios
    .get(`Usuarios?user=like.*${req.body.usuario}*`, {
      headers: {
        accept: "application/json",
      },
    })
    .then((response) => {
      try {
        /* 
        console.log(
          `req login2 ${JSON.stringify(response.data[0]["password"])}`
        ); */
        response.data[0]["token"] = "";
        bcrypt
          .compare(req.body.contrasena, response.data[0]["password"])
          .then((result) => {
            console.log(`result ${result}`);
            if (result) {
              const token = seguridad.generateAccessToken(response.data[0]);
              const tokenUpdate = `{ "token": "${token}"  }`;
              axios
                .patch(
                  `Usuarios?id=eq.${response.data[0]["id"]}`,
                  JSON.parse(tokenUpdate),
                  {
                    headers: {
                      accept: "application/json",
                    },
                  }
                )
                .then((response) => {
                  console.log(`respondo ${JSON.stringify(response.data)}`);
                  res.status(200).json(token);
                })
                .catch((error) => {
                  return error;
                });
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

router.delete("/logout", function (req, res) {
  console.log(`antes del OGOUT`);
  res.json(seguridad.removeAccessToken(req, res));
  console.log(`DESPUES del OGOUT`);
});

router.get(
  "/google",
  passport.authenticate("google", {
    scope: ["profile", "email"],
  }),

  function (req, res) {}
);

router.get(
  "/callback",
  passport.authenticate("google", {
    // scope: [`email`, `profile`],
    // successRedirect: `http://${process.env.HOST_FRONT}/#/home`,
    // successRedirect: `https://www.google.com.ar`,
    failureRdirect: `http://${process.env.HOST_FRONT}/#/`,
    session: false,
  }),
  // midUsers.postCallBack,
  function (req, res) {
    // console.log(`body ${JSON.stringify(req.user)} `);
    // console.log(`storage callback ${storage.getItem("jwt")}`);

    if (req.user.length === 0) {
      res.redirect(`http://${process.env.HOST_FRONT}/#/`);
    } else {
      res.redirect(`http://${process.env.HOST_FRONT}/#/usuarios`);
    }
  }
);

router.get("/returnSession", function (req, res) {
  if (storage.getItem("jwt") === null) {
    console.log(`igual null ${storage.getItem("jwt")}`);
    res.status(401).send({
      status: 401,
      message: "null",
    });
  }
  if (storage.getItem("jwt") !== undefined) {
    tokenDevuelto = storage.getItem("jwt");
    storage.removeItem("jwt");
    res.status(200).send({
      status: 200,
      message: tokenDevuelto,
    });
  } else {
    res.status(401).send({
      status: 401,
      message: "null",
    });
  }
});

module.exports = router;
