// const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const express = require("express");
// const console = require("console");
const router = express.Router();
// sirve para recibir req
router.use(express.urlencoded({ extended: true }));

// configuraciones de axios
const axios = require("../configuraciones/axios");

// get alumno dni
router.get("/:nro_doc", function (req, res) {
  const nro_doc = parseInt(req.params.nro_doc, 10);
  axios
    .get(`Alumno?select=*, Localidad(nombre)&nroDocumento=eq.${nro_doc}`, {
      headers: {
        accept: "application/json",
      },
    })
    .then((response) => {
      res.status(200).json(response.data);
    })
    .catch(function (error) {
      console.log(`error ${error}`);
    });
});

// get
router.get("/", function (req, res) {
  console.log(`req login ${axios}`);
  axios
    .get("Alumno?select=*, Localidad(nombre)", {
      headers: {
        accept: "application/json",
      },
    })
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
    .post("Alumno", req.body, {
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
  axios
    .patch(`Alumno?id=eq.${id}`, req.body, {
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
    .delete(`Alumno?id=eq.${id}`, {
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
