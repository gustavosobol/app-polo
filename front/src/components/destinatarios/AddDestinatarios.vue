<template>
  <div class="full-width row wrap justify-center items-start content-start">
    <div class="column q-pa-lg">
      <q-card square class="shadow-24" style="width: 300px; height: 100%">
        <q-card-section class="bg-deep-purple-7">
          <h4 class="text-h5 text-white q-my-md">Nuevo Destinatario</h4>
        </q-card-section>
        <q-card-section>
          <q-form class="q-px-sm q-pt-xl q-pb-lg">
            <q-input
              square
              clearable
              v-model="nombre"
              type="nombre"
              label="Nombre"
            >
              <template v-slot:prepend>
                <q-icon name="price_change" />
              </template>
            </q-input>
            <q-input
              square
              clearable
              v-model="edadInicio"
              type="number"
              label="Edad Inicio"
            >
              <template v-slot:prepend>
                <q-icon name="inventory" />
              </template>
            </q-input>
            <q-input
              square
              clearable
              v-model="edadFin"
              type="number"
              label="Edad Fin"
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
            @click="addDestinatario"
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
  name: "AddDestinatarios",
  setup() {
    const $q = useQuasar();
    const nombre = ref(null);
    const edadInicio = ref(null);
    const edadFin = ref(null);
    return {
      async addDestinatario() {
        const destinatarioNew = {
          nombre: nombre.value,
          edadInicio: edadInicio.value,
          edadFin: edadFin.value,
        };
        await api
          .post("Destinatarios", destinatarioNew, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se creo el usuario ${nombre.value}`,
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
      nombre,
      edadInicio,
      edadFin,
    };
  },
});
</script>
