<template>
  <q-page class="q-pa-xl">
    <h6 class="q-my-sm">Agregar alumno {{ $route.params.idCurso }}</h6>
    <!--     <div class="col-3 col-sm-3 q-gutter-sm q-col-gutter-sm">
 -->
    <formStudentsVue />
    <!-- </div> -->
  </q-page>
</template>

<script>
import formStudentsVue from "../../components/students/formStudents.vue";

export default {
  components: {
    formStudentsVue,
  },
  setup() {},
};
</script>
