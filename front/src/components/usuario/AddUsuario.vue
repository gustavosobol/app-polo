<template>
  <div class="full-width row wrap justify-center items-start content-start">
    <div class="column q-pa-lg">
      <q-card square class="shadow-24" style="width: 300px; height: 100%">
        <q-card-section class="bg-deep-purple-7">
          <h4 class="text-h5 text-white q-my-md">Nuevo Usuario</h4>
        </q-card-section>
        <q-card-section>
          <q-form class="q-px-sm q-pt-xl q-pb-lg">
            <q-input
              square
              clearable
              v-model="user"
              type="user"
              label="Usuario"
            >
              <template v-slot:prepend>
                <q-icon name="price_change" />
              </template>
            </q-input>

            <q-input
              square
              clearable
              v-model="nombreMostrar"
              type="text"
              label="Nombre Usuario"
            >
              <template v-slot:prepend>
                <q-icon name="price_change" />
              </template>
            </q-input>
            <q-input
              square
              clearable
              v-model="password"
              type="password"
              label="Password"
            >
              <template v-slot:prepend>
                <q-icon name="inventory" />
              </template>
            </q-input>
            <q-input
              square
              clearable
              v-model="descripcion"
              type="text"
              label="Descripción"
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
            @click="addUser"
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
  name: "AddUser",
  setup() {
    const $q = useQuasar();
    const user = ref(null);
    const password = ref(null);
    const descripcion = ref(null);
    const nombreMostrar = ref(null);

    return {
      async addUser() {
        const userNew = {
          user: user.value,
          password: password.value,
          nombreMostrar: nombreMostrar.value,
          descripcion: descripcion.value,
        };
        console.log(`usuario ${JSON.stringify(userNew)}`);
        await api
          /*           .post("Turno", userNew, {
            headers: {
              accept: "application/json",
            },
          }) */
          .post("http://localhost/api-back/usuarios", userNew, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se creo el usuario ${descripcion.value}`,
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
      user,
      descripcion,
      password,
      nombreMostrar,
    };
  },
});
</script>
