const routes = [
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      {
        path: "",
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
    path: "/testing",
    component: () => import("layouts/MainTestLayout.vue"),
  },
  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/Error404.vue"),
  },
];

export default routes;
