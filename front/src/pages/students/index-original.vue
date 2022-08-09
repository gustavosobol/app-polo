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
    <!-- 
    <pre>{{ allStudents }}</pre> -->
    <div v-for="student in allStudents" :key="student.id">
      <Perfil v-bind="student" />
    </div>
  </div>
</template>
<script>
import { ref, onMounted } from "vue";

import { api } from "boot/axios";
import Perfil from "src/components/students/Perfil.vue";

export default {
  setup() {
    let allStudents = ref([]);
    let datos = ref([]);
    let text = ref();
    function returnallStudents() {
      api
        .get(`/Alumno?select=*, Localidad(nombre)`, {
          headers: {
            accept: "application/json",
            //  Authorization: token,
          },
        })
        .then((response) => {
          datos.value = response.data;
          allStudents.value = datos.value;
        });
    }
    onMounted(() => {
      returnallStudents();
    });
    return {
      filtro() {
        allStudents.value = datos.value.filter((row) =>
          row.apellido.includes(text.value)
        );
      },
      allStudents,
      text,
    };
  },

  components: { Perfil },
};
</script>
