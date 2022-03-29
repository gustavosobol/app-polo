const routes = [
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/Index.vue") },
      {
        path: "alumnos",
        name: "Alumnos",
        component: () => import("pages/students/index.vue"),
      },
      {
        path: "cursos",
        name: "Cursos",
        component: () => import("pages/course-registration/index.vue"),
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
    ],
  },
  {
    path: "/testing",
    component: () => import("layouts/MainTestLayout.vue"),
    children: [
      //   { path: '', component: () => import('pages/Index.vue') },
      {
        path: "plantilla",
        component: () => import("pages/plantillas/plantilla.vue"),
      },
      {
        path: "boton",
        component: () => import("pages/plantillas/navegacion.vue"),
      },
      { path: "tabla", component: () => import("pages/plantillas/tabla.vue") },
      {
        path: "tabla2",
        component: () => import("pages/plantillas/tabla2.vue"),
      },
      //{ path: 'dialogo', component: () => import('pages/plantillas/dialogo.vue') },
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
