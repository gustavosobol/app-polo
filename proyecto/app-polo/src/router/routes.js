
const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: '', component: () => import('pages/Index.vue') },
      { path: '/alumnos', component: () => import('pages/add-alumno.vue') },
      { path: '/plantilla', component: () => import('pages/plantilla.vue') },
      { path: '/notifi', component: () => import('pages/notifi.vue') }
    ]
  },
  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/Error404.vue')
  }
]

export default routes
