<template>
  <q-page class="q-pa-xl">
    <h6 class="q-my-sm">Agregar alumno {{ $route.params.idCurso }}</h6>
    <formStudents />
  </q-page>
</template>

<script>
import { useQuasar } from "quasar";
import { ref } from "vue";
import { useRoute } from "vue-router";
import formStudents from "components/students/formStudents.vue";

export default {
  components: {
    formStudents,
  },
  setup() {},
};
</script>
