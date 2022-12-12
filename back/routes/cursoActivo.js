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
router.get("/portal/", function (req, res) {
  axios
    .get(
      "CursosActivos?or=(nombreMostrar.like.**)&and=(activo.eq.true)&select=*,LocalidadOnCurso(nombreMostrar,descripcion, Localidad(nombre),Curso(nombre), Personal(apellido, nombre)),Salas(nombre)",
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

// get
router.get("/", function (req, res) {
  axios
    .get(
      "CursosActivos?select=*, Salas(nombre), LocalidadOnCurso(*, Localidad(nombre), Curso(nombre)), Turno(nombre)",
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
    .post("CursosActivos", req.body, {
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
router.put("/:id", function (req, res) {
  const id = parseInt(req.params.id, 10);
  console.log(`print req.body ${req.body}`);
  axios
    .patch(`CursosActivos?id=eq.${id}`, req.body, {
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

//put
router.put("/activo/:id", function (req, res) {
  const id = parseInt(req.params.id, 10);
  axios
    .patch(`CursosActivos?id=eq.${id}`, req.body, {
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

// delete
router.delete("/:id", function (req, res) {
  const id = parseInt(req.params.id, 10);
  axios
    .delete(`CursosActivos?id=eq.${id}`, {
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
