<template>
  <q-page class="q-pa-xl">
    <h6 class="q-my-sm">Agregar alumno {{ $route.params.idCurso }}</h6>
    <div class="col-3 col-sm-3 q-gutter-sm q-col-gutter-sm">
      <formStudents />
    </div>
  </q-page>
</template>

<script>
import formStudents from "components/students/formStudents.vue";

export default {
  components: {
    formStudents,
  },
  setup() {},
};
</script>
