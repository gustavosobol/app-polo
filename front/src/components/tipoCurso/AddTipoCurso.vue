<template>
  <div class="full-width row wrap justify-center items-start content-start">
    <div class="column q-pa-lg">
      <q-card square class="shadow-24" style="width: 300px; height: 100%">
        <q-card-section class="bg-deep-purple-7">
          <h4 class="text-h5 text-white q-my-md">Nuevo Tipo Curso</h4>
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
                <q-icon name="inventory" />
              </template>
            </q-input>
          </q-form>
        </q-card-section>
        <q-card-actions class="q-px-lg">
          <q-btn
            unelevated
            size="lg"
            color="purple-4"
            class="full-width text-white"
            label="Guardar"
            @click="addTipoCurso"
          />
        </q-card-actions>
      </q-card>
    </div>
  </div>
</template>
<script>
import { ref, defineComponent } from "vue";
import { api } from "boot/axios";
import { useQuasar } from "quasar";
export default defineComponent({
  name: "AddProduct",
  setup() {
    const $q = useQuasar();
    const nombre = ref(null);
    const descripcion = ref(null);
    const edadFin = ref(null);
    return {
      async addTipoCurso() {
        const tipoCursoNew = {
          nombre: nombre.value,
          descripcion: descripcion.value,
        };
        await api
          .post("TipoCurso", tipoCursoNew, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se creo ${nombre.value}`,
              icon: "mood",
            });
            return JSON.stringify(response.data);
          })
          .catch((error) => {
            $q.notify({
              color: "negative",
              position: "bottom",
              message: "No se pudo guardar",
              icon: "sentiment_very_dissatisfied",
            });
          });
      },
      nombre,
      descripcion,
    };
  },
});
</script>
