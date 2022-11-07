<template>
  <div class="full-width row wrap justify-center items-start content-start">
    <div class="column q-pa-lg">
      <q-card square class="shadow-24" style="width: 300px; height: 100%">
        <q-card-section class="bg-deep-purple-7">
          <h4 class="text-h5 text-white q-my-md">Nueva Sala</h4>
        </q-card-section>
        <q-card-section>
          <q-form class="q-px-sm q-pt-xl q-pb-lg">
            <q-input
              square
              clearable
              v-model="nombre"
              type="text"
              label="Nombre"
            >
              <template v-slot:prepend>
                <q-icon name="price_change" />
              </template>
            </q-input>
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

            <q-select
              filled
              v-model="localidadId"
              :options="listaLocalidad"
              option-value="id"
              option-label="nombre"
              label="Localidad"
              :rules="[
                (val) => val !== null || 'Debe seleccionar una localidad',
              ]"
            />
          </q-form>
        </q-card-section>
        <q-card-actions class="q-px-lg">
          <q-btn
            unelevated
            size="lg"
            color="purple-4"
            class="full-width text-white"
            label="Guardar"
            @click="addSala"
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
  name: "AddSalas",
  setup() {
    const localidad = ref([]);
    function returnLocalidad() {
      api
        .get("localidad", {
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
      returnLocalidad();
    });
    const $q = useQuasar();
    const nombre = ref(null);
    const descripcion = ref(null);
    const localidadId = ref(null);
    return {
      async addSala() {
        const salaNew = {
          nombre: nombre.value,
          descripcion: descripcion.value,
          localidadId: localidadId.value.id,
        };
        await api
          .post("sala", salaNew, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se creo el curso ${nombre.value}`,
              icon: "mood",
            });
            return JSON.stringify(response.data);
          })
          .catch((error) => {
            console.log(`error ${JSON.stringify(error)}`);
            $q.notify({
              color: "negative",
              position: "bottom",
              message: "No se pudo guardar el nuevo usuario",
              icon: "sentiment_very_dissatisfied",
            });
          });
      },
      nombre,
      descripcion,
      localidadId,
      listaLocalidad: localidad,
    };
  },
});
</script>
