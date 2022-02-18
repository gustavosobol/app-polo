<template>
  <div>
    <q-input
      filled
      v-model="name"
      label="Nombre"
      hint=""
      lazy-rules
      :rules="[
        (val) => (val && val.length > 0) || 'Complete el campo',
        (val) => (val && val.length < 30) || 'Demasiado largo',
      ]"
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
      type="number"
      v-model="age"
      label="DNI"
      lazy-rules
      :rules="[
        (val) => (val !== null && val !== '') || 'Ingrese el numero de DNI',
        (val) => val.length === 8 || 'El numero debe ser valido',
      ]"
    />

    <q-input
      filled
      v-model="date"
      mask="date"
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

    <q-input
      filled
      v-model="numero_tel"
      type="number"
      label="Numero de telefono"
      hint=""
      lazy-rules
      :rules="[(val) => (val && val.length > 0) || 'Complete el campo']"
    />

    <q-input
      filled
      v-model="numero_contacto"
      type="number"
      label="Numero de contacto en caso de emergencia"
      hint=""
      lazy-rules
      :rules="[(val) => (val && val.length > 0) || 'Complete el campo']"
    />

    <q-input
      filled
      v-model="domicilio"
      label="Domicilio"
      hint=""
      lazy-rules
      :rules="[(val) => (val && val.length > 0) || 'Complete el campo']"
    />

    <q-select filled v-model="model" :options="options" label="Barrio" />
    <div>
      <q-card-section class="col-5 flex flex-center">
        <q-btn
          align="around"
          class="btn-fixed-width"
          color="blue-5"
          label="Agregar"
          icon="note_add"
        />
      </q-card-section>
    </div>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import { useQuasar } from "quasar";
import { useRoute } from "vue-router";

export default defineComponent({
  setup() {
    const $q = useQuasar();

    //FORMULARIOS
    const name = ref(null);
    const apellido = ref(null);
    const age = ref(null);
    const accept = ref(false);
    const numero_tel = ref(null);
    const numero_contacto = ref(null);
    const domicilio = ref(null);

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
      domicilio,
      model: ref(null),
      options: ["Chacra", "Mutual", "Austral"],

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
});
</script>
