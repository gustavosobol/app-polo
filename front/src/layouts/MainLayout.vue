<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />

        <q-toolbar-title> Quasar App </q-toolbar-title>

        <div>Quasar v{{ $q.version }}</div>
      </q-toolbar>
    </q-header>

    <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
      <q-list>
        <q-item-label header> Essential Links </q-item-label>

        <EssentialLink
          v-for="link in essentialLinks"
          :key="link.title"
          v-bind="link"
        />
      </q-list>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import EssentialLink from "components/EssentialLink.vue";

const linksList = [
  {
    title: "Pantalla Principal",
    caption: "Pantalla principal donde aparecen todos los cursos disponibles",
    icon: "favorite",
    link: "#/cursos",
    target: "",
  },
  {
    title: "Alumnos",
    caption: "Listado con todos los alumnos disponibles",
    icon: "school",
    link: "#/alumnos/",
    target: "",
  },
  {
    title: "Turnos",
    caption: "Turnos disponibles ",
    icon: "school",
    link: "#/turnos/",
    target: "",
  },
  {
    title: "Destinatarios",
    caption: "Carga de destinatarios para los cursos",
    icon: "school",
    link: "#/destinatarios/",
    target: "",
  },
  {
    title: "Localidades",
    caption: "Carga de las localidaes",
    icon: "school",
    link: "#/localidades/",
    target: "",
  },
  {
    title: "Tipo Curso",
    caption: "Tipos de cursos que se van a crear",
    icon: "school",
    link: "#/tipoCurso/",
    target: "",
  },
  {
    title: "Personal",
    caption: "Carga de Personal de los polos",
    icon: "school",
    link: "#/personal/",
    target: "",
  },
  {
    title: "Curso",
    caption: "Carga de los cursos con sus detalles correspondientes",
    icon: "school",
    link: "#/CursoDetalle/",
    target: "",
  },
  {
    title: "Salas",
    caption: "Carga salas o aulas que integran los polos",
    icon: "school",
    link: "#/Salas/",
    target: "",
  },
  {
    title: "Localidad Cursos",
    caption: "Carga localidad cursos",
    icon: "school",
    link: "#/localidad-curso/",
    target: "",
  },
  {
    title: "Cursos Activos",
    caption: "Carga cursos activos",
    icon: "school",
    link: "#/curso-activos/",
    target: "",
  },
  {
    title: "Lista Alumnos Cursos Activos",
    caption: "Lista Alumnos Carga cursos activos",
    icon: "school",
    link: "#/listcursos/",
    target: "",
  },
];

import { defineComponent, ref } from "vue";

export default defineComponent({
  name: "MainLayout",

  components: {
    EssentialLink,
  },

  setup() {
    const leftDrawerOpen = ref(false);

    return {
      essentialLinks: linksList,
      leftDrawerOpen,
      toggleLeftDrawer() {
        leftDrawerOpen.value = !leftDrawerOpen.value;
      },
    };
  },
});
</script>
