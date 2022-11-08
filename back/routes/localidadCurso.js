// const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const express = require("express");
// const console = require("console");
const router = express.Router();
// sirve para recibir req
router.use(express.urlencoded({ extended: true }));

// configuraciones de axios
const axios = require("../configuraciones/axios");
// get
router.get("/", function (req, res) {
  axios
    .get(
      "LocalidadOnCurso?select=*, Curso(nombre),Localidad(nombre),Personal(apellido), Destinatarios(nombre)",
      {
        headers: {
          accept: "application/json",
        },
      }
    )
    .then((response) => {
      res.status(200).json(response.data);
    })
    .catch(function (error) {
      console.log(`error ${error}`);
    });
});
// post
router.post("/", function (req, res) {
  axios
    .post("LocalidadOnCurso", req.body, {
      headers: {
        accept: "application/json",
      },
    })
    .then((response) => {
      res.status(200).send({
        status: 200,
        message: "Data find Successfully",
        data: response.data,
      });
    })
    .catch(function (error) {
      console.log(`error ${error}`);
    });
});

//put
router.put("/activo/:idCurso/:idDestinatario", function (req, res) {
  const idCurso = parseInt(req.params.idCurso, 10);
  const idDestinatario = parseInt(req.params.idDestinatario, 10);
  axios
    .patch(
      `LocalidadOnCurso?cursoId=eq.${idCurso}&localidadId=eq.${idDestinatario}`,
      req.body,
      {
        headers: {
          accept: "application/json",
        },
      }
    )
    .then((response) => {
      return response;
    })
    .catch((error) => {
      return error;
    });
});

//put
router.put("/:idCurso/:idDestinatario", function (req, res) {
  const idCurso = parseInt(req.params.idCurso, 10);
  const idDestinatario = parseInt(req.params.idDestinatario, 10);
  axios
    .patch(
      `LocalidadOnCurso?cursoId=eq.${idCurso}&localidadId=eq.${idDestinatario}`,
      req.body,
      {
        headers: {
          accept: "application/json",
        },
      }
    )
    .then((response) => {
      return response;
    })
    .catch((error) => {
      return error;
    });
});

// delete
router.delete("/:id", function (req, res) {
  const id = parseInt(req.params.id, 10);
  axios
    .delete(`LocalidadOnCurso?id=eq.${id}`, {
      headers: {
        accept: "application/json",
      },
    })
    .then((response) => {
      return response;
    })
    .catch((error) => {
      return error;
    });
});

module.exports = router;
