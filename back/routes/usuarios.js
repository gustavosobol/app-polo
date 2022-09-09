// const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const express = require("express");
// const console = require("console");
const router = express.Router();
// sirve para recibir req
router.use(express.urlencoded({ extended: true }));

// configuraciones de axios
const axios = require("../configuraciones/axios");

router.post("/", function (req, res) {
  console.log(`llega ${JSON.stringify(req.body)}`);
  req.body.password = bcrypt.hashSync(req.body.password, 10);
  console.log(`llega2 ${JSON.stringify(req.body)}`);

  axios
    .post("Usuarios", req.body, {
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

router.get("/", function (req, res) {
  axios
    .get("Usuarios", {
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

router.put("/:id", function (req, res) {
  const id = parseInt(req.params.id, 10);
  console.log(`id ${id}`);
  console.log(`body ${JSON.stringify(req.body)}`);
  if (req.body.password != null) {
    req.body.password = bcrypt.hashSync(req.body.password, 10);
    console.log(`llega2 ${JSON.stringify(req.body)}`);
  }
  axios
    .patch(`Usuarios?id=eq.${id}`, req.body, {
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

router.delete("/:id", function (req, res) {
  const id = parseInt(req.params.id, 10);
  axios
    .delete(`Usuarios?id=eq.${id}`, {
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
