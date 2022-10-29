import { SessionStorage } from "quasar";
import { api } from "boot/axios";

const routes = [
  {
    path: "",
    name: "login",
    component: () => import("pages/login/login.vue"),
  },
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      {
        path: "/home",
        name: "home",
        component: () => import("pages/course-registration/index.vue"),
        // component: () => import("pages/Index.vue"),
      },
      {
        path: "alumnos",
        name: "Alumnos",
        component: () => import("pages/students/index.vue"),
      },
      {
        path: "searchalumnos",
        name: "SearchAlumnos",
        component: () => import("pages/students/add-students.vue"),
      },
      {
        path: "cursos",
        name: "Cursos",
        component: () => import("pages/course-registration/index.vue"),
      },
      {
        path: "listcursos",
        name: "ListaCursos",
        component: () => import("pages/course-registration/listIndex.vue"),
      },
      {
        path: "nuevocursos",
        name: "NuevoCursos",
        component: () => import("pages/curso/addCurso.vue"),
      },
      {
        path: "personal",
        name: "Personal",
        component: () => import("pages/personal/index.vue"),
      },
      {
        path: "turnos",
        name: "Turnos",
        component: () => import("pages/turnos/index.vue"),
      },
      {
        path: "destinatarios",
        name: "Destinatarios",
        component: () => import("pages/destinatarios/index.vue"),
      },
      {
        path: "localidades",
        name: "Localidad",
        component: () => import("pages/localidad/index.vue"),
      },
      {
        path: "tipoCurso",
        name: "TipoCurso",
        component: () => import("pages/tipoCurso/index.vue"),
      },
      {
        path: "cursoDetalle",
        name: "CursoDetalle",
        component: () => import("pages/cursoDetalle/index.vue"),
      },
      {
        path: "salas",
        name: "Salas",
        component: () => import("pages/salas/index.vue"),
      },
      {
        path: "usuarios",
        name: "Usuarios",
        component: () => import("pages/usuarios/index.vue"),
        // component: () => import("pages/Index.vue"),
        beforeEnter: (to, from, next) => {
          // ...
          if (SessionStorage.getItem("jwt") === null) {
            api
              .get("returnSession", {
                headers: {
                  accept: "application/json",
                },
              })
              .then((response) => {
                SessionStorage.set("jwt", response.data.message);
                next();
              })
              .catch((error) => {
                next({ name: "login" });
              });
          } else {
            next();
          }
        },
      },
      {
        path: "localidad-curso",
        name: "LocalidadCurso",
        component: () => import("pages/localidadCurso/index.vue"),
      },
      {
        path: "curso-activos",
        name: "CursoActivos",
        component: () => import("pages/cursoActivos/index.vue"),
      },
    ],
  },
  {
    path: "/MesaEntrada",
    component: () => import("layouts/MesaEntradaLayout.vue"),
    children: [
      {
        path: "",
        component: () => import("pages/course-registration/index.vue"),
        // component: () => import("pages/Index.vue"),
      },
      {
        path: "cursos",
        name: "MesaEntrada-Cursos",
        component: () => import("pages/course-registration/index.vue"),
      },
      {
        path: "alumnos",
        name: "MesaEntrada-Alumnos",
        component: () => import("pages/students/index.vue"),
      },
      {
        path: "searchalumnos",
        name: "MesaEntrada-SearchAlumnos",
        component: () => import("pages/students/add-students.vue"),
      },
      {
        path: "personal",
        name: "MesaEntrada-Personal",
        component: () => import("pages/personal/index.vue"),
      },

      {
        path: "curso-activos",
        name: "MesaEntrada-CursoActivos",
        component: () => import("pages/cursoActivos/index.vue"),
      },
      {
        path: "listcursos",
        name: "MesaEntrada-ListaCursos",
        component: () => import("pages/course-registration/listIndex.vue"),
      },
    ],
  },
  {
    path: "/Admin",
    component: () => import("layouts/AdminLayout.vue"),
    children: [
      {
        path: "",
        component: () => import("pages/course-registration/index.vue"),
        // component: () => import("pages/Index.vue"),
      },
      {
        path: "alumnos",
        name: "Admin-Alumnos",
        component: () => import("pages/students/index.vue"),
      },
      {
        path: "searchalumnos",
        name: "Admin-SearchAlumnos",
        component: () => import("pages/students/add-students.vue"),
      },
      {
        path: "cursos",
        name: "Admin-Cursos",
        component: () => import("pages/course-registration/index.vue"),
      },
      {
        path: "listcursos",
        name: "Admin-ListaCursos",
        component: () => import("pages/course-registration/listIndex.vue"),
      },
      {
        path: "nuevocursos",
        name: "Admin-NuevoCursos",
        component: () => import("pages/curso/addCurso.vue"),
      },
      {
        path: "personal",
        name: "Admin-Personal",
        component: () => import("pages/personal/index.vue"),
      },
      {
        path: "turnos",
        name: "Admin-Turnos",
        component: () => import("pages/turnos/index.vue"),
      },
      {
        path: "destinatarios",
        name: "Admin-Destinatarios",
        component: () => import("pages/destinatarios/index.vue"),
      },
      {
        path: "localidades",
        name: "Admin-Localidad",
        component: () => import("pages/localidad/index.vue"),
      },
      {
        path: "tipoCurso",
        name: "Admin-TipoCurso",
        component: () => import("pages/tipoCurso/index.vue"),
      },
      {
        path: "cursoDetalle",
        name: "Admin-CursoDetalle",
        component: () => import("pages/cursoDetalle/index.vue"),
      },
      {
        path: "salas",
        name: "Admin-Salas",
        component: () => import("pages/salas/index.vue"),
      },

      {
        path: "localidad-curso",
        name: "Admin-LocalidadCurso",
        component: () => import("pages/localidadCurso/index.vue"),
      },
      {
        path: "curso-activos",
        name: "Admin-CursoActivos",
        component: () => import("pages/cursoActivos/index.vue"),
      },
    ],
  },
  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/Error404.vue"),
  },
];

export default routes;
