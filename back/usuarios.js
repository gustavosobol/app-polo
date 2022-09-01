const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const express = require("express");
const router = express.Router();
// sirve para recibir req
router.use(express.urlencoded({ extended: true }));

router.get("/", function (req, res) {
  res.status(200).send({
    status: 200,
    message: "Data find Successfully",
  });
});
module.exports = router;
