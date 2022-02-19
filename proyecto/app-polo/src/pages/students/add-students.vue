<template>
  <q-page class="q-pa-xl">
  <h6 class="q-my-sm">Agregar alumno {{ $route.params.idCurso }}</h6>
  <div class="row q-col-gutter-sm q-ma-xs">
    <formStudents />
    <Perfil :title="name" :apellido="apellido" :name="name"/>
    </div>
  </q-page>
</template>

<script>
import formStudents from "components/students/formStudents.vue";
import Perfil from "components/students/Perfil.vue";


export default {
  components: {
    formStudents,
    Perfil,
  },
  setup() {

  },
};
</script>
