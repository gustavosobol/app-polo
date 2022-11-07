<template>
  <q-form @reset="onReset" class="q-gutter-md">
    <q-input
      filled
      type="number"
      v-model="nroDocumento"
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
      :rules="[(val) => (val && val.length > 0) || 'Debe ingresar su apellido']"
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
            <!--  mask="MM-DD-YYYY" -->
            <q-date v-model="date">
              <div class="row items-center justify-end">
                <q-btn v-close-popup label="Close" color="primary" flat />
              </div>
            </q-date>
          </q-popup-proxy>
        </q-icon>
      </template>
    </q-input>

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
        (val) => (val && val.length > 0) || 'Debe ingresar un nro de celular',
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
    <div class="q-pb-sm">barrio: {{ barrio }}</div>
    <q-select
      filled
      v-model="barrio"
      :options="listaBarrios"
      label="Barrio"
      :rules="[(val) => val !== null || 'Debe seleccionar un barrio']"
    />
    <q-select
      filled
      v-model="localidadId"
      :options="listaLocalidades"
      option-value="id"
      option-label="nombre"
      label="Localidad"
      :rules="[(val) => val !== null || 'Debe seleccionar una localidad']"
    />

    <div>
      <q-btn
        label="Guardar"
        type="submit"
        color="primary"
        style="max-width: 1000px"
        @click="addPersonal"
      />
      <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm" />
    </div>
  </q-form>
</template>

<script>
import { defineComponent, ref, onMounted } from "vue";
import { useQuasar } from "quasar";
import { useRoute } from "vue-router";
import { api } from "boot/axios";
export default defineComponent({
  setup() {
    const localidades = ref([]);
    function returnLocalidades() {
      api
        .get("Localidad", {
          headers: {
            accept: "application/json",
          },
        })
        .then((response) => {
          localidades.value = response.data;
          console.log(`localidades  ${JSON.stringify(localidades)}`);
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
      returnLocalidades();
    });

    const $q = useQuasar();
    const route = useRoute();
    //FORMULARIOS
    const nroDocumento = ref(null);
    const apellido = ref(null);
    const nombre = ref(null);
    const email = ref(null);
    const celular = ref(null);
    const domicilio = ref(null);
    const barrio = ref(null);
    const localidadId = ref(null);

    //CALENDARIO
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, "0");
    var mm = String(today.getMonth() + 1).padStart(2, "0"); //January is 0!
    var yyyy = today.getFullYear();
    // today = dd + "/" + mm + "/" + yyyy;
    today = yyyy + "/" + mm + "/" + dd;
    const date = ref(today);
    return {
      //FORMULARIOS
      nroDocumento,
      apellido,
      nombre,
      date,
      email,
      celular,
      domicilio,
      barrio,
      listaBarrios: ["Chacra", "Mutual", "Austral"],
      localidadId,
      listaLocalidades: localidades,

      async addPersonal() {
        const personalNew = {
          nroDocumento: nroDocumento.value,
          apellido: apellido.value,
          nombre: nombre.value,
          fechaNacimiento: date.value,
          email: email.value,
          celular: celular.value,
          domicilio: domicilio.value,
          barrio: barrio.value,
          localidadId: localidadId.value.id,
        };
        await api
          .post("personal", personalNew, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se creo el personal ${nombre.value}`,
              icon: "mood",
            });
            return JSON.stringify(response.data);
          })
          .catch((error) => {
            console.log(`error personal ${error}`);
            $q.notify({
              color: "negative",
              position: "bottom",
              message: "No se pudo guardar el nuevo usuario",
              icon: "sentiment_very_dissatisfied",
            });
          });
      },

      onReset() {
        nroDocumento.value = null;
        apellido.value = null;
        nombre.value = null;
        date.value = today;
        email.value = null;
        celular.value = null;
        domicilio.value = null;
        barrio.value = null;
        localidadId.value = null;
      },
    };
  },
  methods: {},
});
</script>
