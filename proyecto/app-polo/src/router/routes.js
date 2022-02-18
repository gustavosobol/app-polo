const routes = [
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/Index.vue") },
      {
        path: "alumnos",
        name: "Alumnos",
        component: () => import("pages/students/add-students.vue"),
      },
      {
        path: "cursos",
        name: "Cursos",
        component: () => import("pages/course-registration/index.vue"),
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
