require("dotenv").config();
const jwt = require("jsonwebtoken");
const axios = require("../configuraciones/axios");
let generateAccessToken = (username) => {
  return jwt.sign({ dataUser: username }, process.env.JWT_SECRET, {
    expiresIn: 3600,
  });
};

let removeAccessToken = (username) => {
  const tokenUpdate = `{ "token": ""  }`;
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
      res.status(200).json(response.data);
    })
    .catch((error) => {
      return error;
    });
};

module.exports = { generateAccessToken, removeAccessToken };
