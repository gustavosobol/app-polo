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
    .get("Localidad", {
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
    .post("Localidad", req.body, {
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
  console.log(`id ${id}`);
  console.log(`body ${JSON.stringify(req.body)}`);
  if (req.body.password != null) {
    req.body.password = bcrypt.hashSync(req.body.password, 10);
    console.log(`llega2 ${JSON.stringify(req.body)}`);
  }
  axios
    .patch(`Localidad?id=eq.${id}`, req.body, {
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
    .delete(`Localidad?id=eq.${id}`, {
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
