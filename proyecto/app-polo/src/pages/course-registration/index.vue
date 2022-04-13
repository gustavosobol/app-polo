<template>
  <div class="q-pa-md row items-start q-gutter-md">
    <div class="q-gutter-y-md column" style="width: 100%">
      <q-input rounded bottom-slots v-model="text" @keyup="filtro">
        <template v-slot:append>
          <q-avatar>
            <img src="~assets/boy-avatar.png" />
          </q-avatar>
        </template>
      </q-input>
    </div>

    <!--    <pre>{{ allCursos }}</pre> -->
    <div v-for="curso in allCursos" :key="curso.id">
      <CursosDetail v-bind="curso" />
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";

import { api } from "boot/axios";
import CursosDetail from "../../components/cursos/cursosDetail.vue";

export default {
  setup() {
    let allCursos = ref([]);
    let datos = ref([]);
    let text = ref();
    function returnAllCursos() {
      api
        .get(
          `/CursosActivos?or=(nombreMostrar.like.**)&select=*,LocalidadOnCurso(nombreMostrar,Localidad(nombre),Curso(nombre)),Salas(nombre)`,
          {
            headers: {
              accept: "application/json",
              //  Authorization: token,
            },
          }
        )
        .then((response) => {
          datos.value = response.data;
          allCursos.value = datos.value;
        });
    }
    onMounted(() => {
      returnAllCursos();
    });
    return {
      filtro() {
        allCursos.value = datos.value.filter((row) =>
          row.nombreMostrar.includes(text.value)
        );
      },
      allCursos,

      text,
    };
  },

  components: { CursosDetail },
};
</script>
