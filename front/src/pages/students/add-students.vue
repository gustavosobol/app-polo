<template>
  <q-page class="q-pa-xl">
    <h6 class="q-my-sm">Agregar alumno {{ $route.params.nombreCurso }}</h6>
    <div class="row q-col-gutter-sm q-ma-xs">
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <formStudentsVue @getData="getData" />
      </div>
      <!--       <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <pre>{{ JSON.stringify(datos) }}</pre>
        <perfil v-bind="datos" />
      </div> -->
    </div>
  </q-page>
</template>

<script>
import formStudentsVue from "../../components/students/formStudents.vue";
/* import Perfil from "../../components/students/Perfil.vue"; */
import { ref } from "vue";

export default {
  components: {
    formStudentsVue,
    /*   Perfil, */
  },
  methods: {
    getData(data) {
      this.datos = data; // { nombre: data.nombre, apellido: data.apellido };
    },
  },
  setup() {
    const datos = ref(null);
    return {
      datos,
    };
  },
};
</script>
<style scoped>
.wave {
  position: fixed;
  height: 100%;
  left: 0;
  bottom: 0;
  z-index: -1;
}

.titulo-card {
  position: relative;
  color: white;
  background: radial-gradient(circle, #6ba577 0%, #c7bb77 100%);
  top: 5px;
  left: 10px;
  width: 100%;
  max-width: 250px;
  right: 1;
  z-index: -1;
}
</style>
