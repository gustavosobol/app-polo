<template>
  <q-form @submit="onSubmit" @reset="onReset" class="q-gutter-md">
    <div class="row sm-gutter">
      <div class="col-12 col-sm-6 q-gutter-sm q-col-gutter-sm">
        <!-- Columna1 -->
        <!--Documento-->
        <q-input
          filled
          type="number"
          v-model="nro_doc"
          label="Nro Documento"
          lazy-rules
          :rules="[
            (val) =>
              (val !== null && val !== '') || 'Ingrese su número de documento',
            (val) => val.length === 8 || 'El numero debe ser valido',
          ]"
        />
        <!-- Apellido -->
        <q-input
          filled
          v-model="apellido"
          label="Apellido"
          hint=""
          lazy-rules
          :rules="[
            (val) => (val && val.length > 0) || 'Debe ingresar su apellido',
          ]"
        />
        <!-- Nombre -->
        <q-input
          filled
          v-model="nombre"
          label="Nombre"
          hint=""
          lazy-rules
          :rules="[
            (val) => (val && val.length > 0) || 'Debe ingresar su nombre',
            (val) => (val && val.length < 30) || 'Demasiado largo',
          ]"
        />
        <!-- Fecha Nacimiento -->
        <q-input
          filled
          v-model="date"
          mask="date"
          label="Fecha Nacimiento"
          :rules="['date']"
          hint=""
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

      <div class="col-12 col-sm-6 q-gutter-sm q-col-gutter-sm">
        <!-- Columna2 -->
        <!-- email -->
        <q-input
          filled
          v-model="email"
          type="email"
          label="Mail"
          hint=""
          lazy-rules
          :rules="[
            (val) =>
              /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(val) ||
              'Debe ingresar un mail valido',
          ]"
        />
        <q-input
          filled
          v-model="celular"
          type="number"
          label="Celular"
          hint=""
          lazy-rules
          :rules="[
            (val) =>
              (val && val.length > 0) || 'Debe ingresar un nro de celular',
          ]"
        />

        <q-input
          filled
          v-model="domicilio"
          label="Domicilio"
          hint=""
          lazy-rules
          :rules="[
            (val) => (val && val.length > 0) || 'Debe ingresar un domicilio',
          ]"
        />

        <q-select
          filled
          v-model="barrio"
          :options="listaBarrios"
          label="Barrio"
          :rules="[(val) => val !== null || 'Debe seleccionar un barrio']"
        />
      </div>
    </div>

    <q-toggle v-model="accept" label="Acepta la inscripción" />

    <div>
      <q-btn
        label="Submit"
        type="submit"
        color="primary"
        style="max-width: 1000px"
      />
      <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm" />
    </div>
  </q-form>
</template>

<script>
import { defineComponent, ref } from "vue";
import { useQuasar } from "quasar";
import { useRoute } from "vue-router";

export default defineComponent({
  setup() {
    const $q = useQuasar();
    const route = useRoute();

    //FORMULARIOS
    const nro_doc = ref(route.params.idAlumno);
    const apellido = ref(null);
    const nombre = ref(null);
    const email = ref(null);
    const celular = ref(null);
    const domicilio = ref(null);
    const barrio = ref(null);
    const accept = ref(false);
    //CALENDARIO
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, "0");
    var mm = String(today.getMonth() + 1).padStart(2, "0"); //January is 0!
    var yyyy = today.getFullYear();

    today = yyyy + "/" + mm + "/" + dd;

    return {
      //FORMULARIOS
      nro_doc,
      apellido,
      nombre,
      date: ref(today),
      email,
      celular,
      domicilio,

      barrio: ref(null),
      listaBarrios: ["Chacra", "Mutual", "Austral"],
      //CALENDARIO
      splitterModel: ref(50),
      accept,

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
        nro_doc.value = null;
        apellido.value = null;
        nombre.value = null;
        date.value = today;
        email.value = null;
        celular.value = null;
        domicilio.value = null;
        barrio.value = null;
        accept.value = false;
      },
    };
  },
});
</script>
