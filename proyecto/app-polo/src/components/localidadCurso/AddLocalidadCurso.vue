<template>
  <div class="full-width row wrap justify-center items-start content-start">
    <div class="column q-pa-lg">
      <q-card square class="shadow-24" style="width: 300px; height: 100%">
        <q-card-section class="bg-deep-purple-7">
          <h4 class="text-h5 text-white q-my-md">Nuevo Curso Localidad</h4>
        </q-card-section>
        <q-card-section>
          <q-form class="q-px-sm q-pt-xl q-pb-lg">
            <q-select
              filled
              v-model="cursoId"
              :options="listaCurso"
              option-value="id"
              option-label="nombre"
              label="Tipo Cursos"
              :rules="[
                (val) => val !== null || 'Debe seleccionar una localidad',
              ]"
            />
            <q-select
              filled
              v-model="localidadId"
              :options="listaLocalidad"
              option-value="id"
              option-label="nombre"
              label="Localidad "
              :rules="[
                (val) => val !== null || 'Debe seleccionar una localidad',
              ]"
            />

            <q-input
              square
              clearable
              v-model="descripcion"
              type="text"
              label="Descripcion"
            >
              <template v-slot:prepend>
                <q-icon name="price_change" />
              </template>
            </q-input>

            <q-checkbox label="vigente" v-model="vigente" />
          </q-form>
        </q-card-section>
        <q-card-actions class="q-px-lg">
          <q-btn
            unelevated
            size="lg"
            color="purple-4"
            class="full-width text-white"
            label="Guardar"
            @click="addCursoLocalidad"
          />
        </q-card-actions>
      </q-card>
    </div>
  </div>
</template>
<script>
import { ref, defineComponent, onMounted } from "vue";
import { api } from "boot/axios";
import { useQuasar } from "quasar";
export default defineComponent({
  name: "AddLocalidadCurso",
  setup() {
    const curso = ref([]);
    const localidad = ref([]);
    function returnCurso() {
      api
        .get("Curso", {
          headers: {
            accept: "application/json",
          },
        })
        .then((response) => {
          curso.value = response.data;
        })
        .catch((error) => {
          $q.notify({
            color: "negative",
            position: "bottom",
            message: `code: ${error.response.status} - Mensaje ${error}`,
            icon: "report_problem",
          });
        });
    }
    function returnLocalidad() {
      api
        .get("Localidad", {
          headers: {
            accept: "application/json",
          },
        })
        .then((response) => {
          localidad.value = response.data;
        })
        .catch((error) => {
          $q.notify({
            color: "negative",
            position: "bottom",
            message: `code: ${error.response.status} - Mensaje ${error}`,
            icon: "report_problem",
          });
        });
    }
    onMounted(() => {
      returnCurso();
      returnLocalidad();
    });
    const $q = useQuasar();
    const descripcion = ref(null);
    const cursoId = ref(null);
    const localidadId = ref(null);
    const vigente = ref(false);
    return {
      async addCursoLocalidad() {
        const localidadCursoNew = {
          cursoId: cursoId.value.id,
          localidadId: localidadId.value.id,
          descripcion: descripcion.value,
          vigente: vigente.value,
          nombreMostrar: `${cursoId.value.nombre} - ${localidadId.value.nombre}`,
        };
        console.log(`add curso ${JSON.stringify(localidadCursoNew)}`);
        await api
          .post("LocalidadOnCurso", localidadCursoNew, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se creo el curso ${localidadCursoNew.nombreMostrar}`,
              icon: "mood",
            });
            return JSON.stringify(response.data);
          })
          .catch((error) => {
            $q.notify({
              color: "negative",
              position: "bottom",
              message: "No se pudo guardar el nuevo usuario",
              icon: "sentiment_very_dissatisfied",
            });
          });
      },

      cursoId,
      localidadId,
      descripcion,
      vigente,
      listaCurso: curso,
      listaLocalidad: localidad,
    };
  },
});
</script>
