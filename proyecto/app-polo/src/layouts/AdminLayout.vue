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
    icon: "home",
    link: "#/Admin/cursos",
    target: "",
  },
  {
    title: "01 - Localidades",
    caption: "Carga de las localidaes",
    icon: "location_city",
    link: "#/Admin/localidades/",
    target: "",
  },
  {
    title: "02 - Tipo Curso",
    caption: "Tipos de cursos que se van a crear",
    icon: "school",
    link: "#/Admin/tipoCurso/",
    target: "",
  },
  {
    title: "03 - Destinatarios",
    caption: "Carga de destinatarios para los cursos",
    icon: "family_restroom",
    link: "#/Admin/destinatarios/",
    target: "",
  },
  {
    title: "04 - Turnos",
    caption: "Turnos disponibles ",
    icon: "more_time",
    link: "#/Admin/turnos/",
    target: "",
  },
  {
    title: "05 - Salas",
    caption: "Carga salas o aulas que integran los polos",
    icon: "class",
    link: "#/Admin/Salas/",
    target: "",
  },
  {
    title: "06 - Curso",
    caption: "Carga de los cursos con sus detalles correspondientes",
    icon: "school",
    link: "#/Admin/CursoDetalle/",
    target: "",
  },
  {
    title: "07 - Personal",
    caption: "Carga de Personal de los polos",
    icon: "person",
    link: "#/Admin/personal/",
    target: "",
  },
  {
    title: "08 - Localidad Cursos",
    caption: "Carga localidad cursos",
    icon: "store",
    link: "#/Admin/localidad-curso/",
    target: "",
  },
  {
    title: "09 - Cursos Activos",
    caption: "Carga cursos activos",
    icon: "toggle_on",
    link: "#/Admin/curso-activos/",
    target: "",
  },

  {
    title: "10 - Alumnos",
    caption: "Listado con todos los alumnos disponibles",
    icon: "emoji_people",
    link: "#/Admin/alumnos/",
    target: "",
  },

  {
    title: "11 - Lista Alumnos Cursos Activos",
    caption: "Lista Alumnos Carga cursos activos",
    icon: "people_outline",
    link: "#/Admin/listcursos/",
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
