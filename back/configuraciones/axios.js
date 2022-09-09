const axios = require("axios").default;
axios.defaults.baseURL = "http://192.168.1.45/api/";

module.exports = axios;
