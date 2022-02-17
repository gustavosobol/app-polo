<template>
  <div class="q-pa-md" style="max-width: 400px">
    <q-form @submit="onSubmit" @reset="onReset" class="q-gutter-md">
      <q-input
        filled
        v-model="name"
        label="Nombre"
        hint=""
        lazy-rules
        :rules="[(val) => (val && val.length > 0) || 'Complete el campo']"
      />

      <q-input
        filled
        v-model="apellido"
        label="Apellido"
        hint=""
        lazy-rules
        :rules="[(val) => (val && val.length > 0) || 'Complete el campo']"
      />

      <q-input
        filled
        v-model="numero_tel"
        label="Numero de telefono"
        hint=""
        lazy-rules
        :rules="[(val) => (val && val.length > 0) || 'Complete el campo']"
      />

      <q-input
        filled
        v-model="numero_contacto"
        label="Numero de contacto"
        hint="Para emergencias"
        lazy-rules
        :rules="[(val) => (val && val.length > 0) || 'Complete el campo']"
      />

      <q-input
        filled
        type="number"
        v-model="age"
        label="Your age *"
        lazy-rules
        :rules="[
          (val) => (val !== null && val !== '') || 'Ingrese la edad',
          (val) => (val > 0 && val < 100) || 'La edad debe ser real',
        ]"
      />

      <div class="q-pa-md" style="max-width: 400px">
        <q-input
          filled
          v-model="date"
          mask=""
          :rules="['date']"
          hint="Fecha de nacimiento"
        >
          <template v-slot:append>
            <q-icon name="event" class="cursor-pointer">
              <q-popup-proxy
                ref="qDateProxy"
                cover
                transition-show="scale"
                transition-hide="scale"
              >
                <q-date v-model="date">
                  <div class="row items-center justify-end">
                    <q-btn v-close-popup label="Close" color="primary" flat />
                  </div>
                </q-date>
              </q-popup-proxy>
            </q-icon>
          </template>
        </q-input>
      </div>

      <form>
        <div>DEBUG</div>
        <div>La fecha de nacimiento ingresada es: {{ date }}</div>
        <div>El curso seleccionado es: {{ $route.params.idAlumno }}</div>
        <div>El curso seleccionado es: {{ $route.params.idCurso }}</div>
        <div>date es: {{ date }}</div>
      </form>

      <q-toggle v-model="accept" label="I accept the license and terms" />

      <div>
        <q-btn label="Submit" type="submit" color="primary" />
        <q-btn
          label="Reset"
          type="reset"
          color="primary"
          flat
          class="q-ml-sm"
        />
      </div>
    </q-form>
  </div>
</template>

<script>
import { useQuasar } from "quasar";
import { ref } from "vue";

export default {
  setup() {
    const $q = useQuasar();

    //FORMULARIOS
    const name = ref(null);
    const apellido = ref(null);
    const age = ref(null);
    const accept = ref(false);
    const numero_tel = ref(null);
    const numero_contacto = ref(null);

    //CALENDARIO
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, "0");
    var mm = String(today.getMonth() + 1).padStart(2, "0"); //January is 0!
    var yyyy = today.getFullYear();

    today = dd + "/" + mm + "/" + yyyy;

    return {
      //FORMULARIOS
      name,
      age,
      accept,
      apellido,
      numero_tel,
      numero_contacto,

      //CALENDARIO
      splitterModel: ref(50),
      date: ref(today),

      onSubmit() {
        if (accept.value !== true) {
          $q.notify({
            color: "red-5",
            textColor: "white",
            icon: "warning",
            message: "You need to accept the license and terms first",
          });
        } else {
          $q.notify({
            color: "green-4",
            textColor: "white",
            icon: "cloud_done",
            message: "Submitted",
          });
        }
      },

      onReset() {
        name.value = null;
        age.value = null;
        accept.value = false;
      },
    };
  },
};
</script>
