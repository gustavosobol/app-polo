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
    title: "Cursos",
    caption: "Community Quasar projects",
    icon: "favorite",
    link: "#/cursos",
    target: "",
  },
  {
    title: "Alumnos",
    caption: "Community Quasar projects",
    icon: "school",
    link: "#/alumnos/",
    target: "",
  },
  {
    title: "Turnos",
    caption: "Community Quasar projects",
    icon: "school",
    link: "#/turnos/",
    target: "",
  },
  {
    title: "Destinatarios",
    caption: "Community Quasar projects",
    icon: "school",
    link: "#/destinatarios/",
    target: "",
  },
  {
    title: "Localidades",
    caption: "Community Quasar projects",
    icon: "school",
    link: "#/localidades/",
    target: "",
  },
  {
    title: "TipoCurso",
    caption: "Community Quasar projects",
    icon: "school",
    link: "#/tipoCurso/",
    target: "",
  },
  {
    title: "Personal",
    caption: "Carga de Personal",
    icon: "school",
    link: "#/personal/",
    target: "",
  },
  {
    title: "Curso Detalle",
    caption: "Carga de Cursos",
    icon: "school",
    link: "#/CursoDetalle/",
    target: "",
  },
  {
    title: "Salas",
    caption: "Carga Salas",
    icon: "school",
    link: "#/Salas/",
    target: "",
  },
  {
    title: "Destinatario Curso",
    caption: "Carga Salas",
    icon: "school",
    link: "#/destinatario-curso/",
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
