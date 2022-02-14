<template>
  <div class="q-pa-md" style="max-width: 300px">
    <form
      @submit.prevent.stop="onSubmit"
      @reset.prevent.stop="onReset"
      class="q-gutter-md"
    >
      <q-input
        ref="apellidoRef"
        filled
        v-model="apellido"
        label="Ingrese su apellido *"
        hint="Ingrese su apellido"
        lazy-rules
        :rules="nameRules"
        @keyup="upper"
      />
      <q-input
        ref="nameRef"
        filled
        label="Ingrese su nombre *"
        hint="Nombre"
        lazy-rules
        :rules="nameRules"
      />
      <q-input
        ref="ageRef"
        filled
        type="number"
        v-model="age"
        label="Your age *"
        lazy-rules
        :rules="ageRules"
      />

      <q-input
        filled
        v-model="serialNumber"
        label="To Upper Case"
        @input="
          (val) => {
            serialNumber = val.toUpperCase();
          }
        "
      ></q-input>

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
    </form>
  </div>
</template>

<script>
import { useQuasar } from "quasar";
import { ref } from "vue";

export default {
  setup() {
    const $q = useQuasar();

    const name = ref(null);
    const nameRef = ref(null);

    const apellido = ref(null);
    const apellidoRef = ref(null);

    const age = ref(null);
    const ageRef = ref(null);

    const accept = ref(false);

    return {
      serialNumber: null,

      apellido,
      apellidoRef,
      apellidoRules: [
        (val) => (val && val.length > 0) || "Please type something",
      ],
      name,
      nameRef,
      nameRules: [(val) => (val && val.length > 0) || "Please type something"],

      age,
      ageRef,
      ageRules: [
        (val) => (val !== null && val !== "") || "Por favor ingrese su edad ",
        (val) => (val > 0 && val < 100) || "Please type a real age",
      ],

      accept,
      upper(e) {
        console.log("llego", e.target.value.toUpperCase());
        e.target.value = e.target.value.toUpperCase();
      },

      onSubmit() {
        nameRef.value.validate(); // aca escribe sobre el accept.value , true o false
        ageRef.value.validate();
        console.log(`valor`, nameRef.value.hasError);
        if (nameRef.value.hasError || ageRef.value.hasError) {
          // form has error
          $q.notify({
            icon: "done",
            color: "negative",
            message: "Debes completar todos los datos",
          });
        } else if (accept.value !== true) {
          $q.notify({
            color: "negative",
            message: "You need to accept the license and terms first",
          });
        } else {
          $q.notify({
            icon: "done",
            color: "positive",
            message: "Submitted",
          });
        }
      },

      onReset() {
        name.value = null;
        age.value = null;

        nameRef.value.resetValidation();
        ageRef.value.resetValidation();
      },
      validate() {
        console.log("hola");
        return false;
      },
    };
  },
};
</script>
