import { boot } from "quasar/wrappers";
import axios from "axios";

// Be careful when using SSR for cross-request state pollution
// due to creating a Singleton instance here;
// If any client changes this (global) instance, it might be a
// good idea to move this instance creation inside of the
// "export default () => {}" function below (which runs individually
// for each client)
const api = axios.create({ baseURL: "http://192.168.1.45:3000/" });

export default boot(({ app }) => {
  // for use inside Vue files (Options API) through this.$axios and this.$api

  app.config.globalProperties.$axios = axios;
  // ^ ^ ^ this will allow you to use this.$axios (for Vue Options API form)
  //       so you won't necessarily have to import axios in each vue file

  app.config.globalProperties.$api = api;
  // ^ ^ ^ this will allow you to use this.$api (for Vue Options API form)
  //       so you can easily perform requests against your app's API
});

export { api };

/* {"id":1,
"nombreMostrar":"sala2 - curso 2 - Rio Grande",
"fechaInicio":"2021-07-05",
"fechaFin":"2021-07-24",
"horario":"20 a 22",
"cupos":2,
"descripcion":"",
"LocalidadOnCurso":{"nombreMostrar":"curso 2 - Rio Grande"},



"activo":true,





"salaId":2,

"cursoId":2,
"localidadId":2,
"Salas":{"nombre":"sala2"}}
} */
