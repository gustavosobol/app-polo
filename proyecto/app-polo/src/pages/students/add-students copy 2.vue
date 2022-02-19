<template>
  <q-page class="q-pa-xl">
    <q-img src="~assets/fondo.jpg" class="wave"/>

  <div class="row q-col-gutter-sm q-ma-xs" :style="image" >
    <!-- Columna1 -->
    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">

  <q-form @submit="onSubmit" @reset="onReset" class="q-gutter-md">
  
  <q-card>
  <q-card-section>
    
    <!-- Columna1 -->
    <h5 class="q-my-sm">Agregar alumno {{ $route.params.idCurso }}</h5>
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
      label="Correo"
      hint=""
      lazy-rules
      :rules="[
        (val) =>
          /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(val) ||
          'Debe ingresar un mail valido',
      ]">
       <template v-slot:prepend>
          <q-icon name="mail" />
        </template>
      </q-input>

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

    <q-select
      filled
      v-model="barrio"
      :options="listaBarrios"
      label="Barrio"
      :rules="[(val) => val !== null || 'Debe seleccionar un barrio']"
    />

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
    </q-card-section>
    </q-card>
    </q-form>
    </div>

     <!-- Columna2 -->

     
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
    <q-card class="my-card" flat bordered>
      <q-card-section horizontal>
        <q-card-section class="q-pt-xs">
          <div class="text-overline">Perfil</div>
          <div class="text-h5 q-mt-sm q-mb-xs">
            {{ title }} - {{ nombre }} {{ apellido }}
          </div>

          <div class="text-caption text-grey">Edad: {{ date }}</div>
          <div class="text-caption text-grey">Telefono: {{ numero_tel }}</div>
          <div class="text-caption text-grey">
            Telefono URGENCIAS: {{ numero_contacto }}
          </div>
          <div class="text-caption text-grey">
            Vive en: {{ domicilio }} , Barrio
          </div>
          <h1 v-if="!isHidden"><q-btn color="primary" label="QR" @click="generateQrCode()" size="xl" id="qr-button"/></h1>
          <div><canvas id="qr-code"></canvas></div>
        </q-card-section>

        <q-card-section class="col-5 flex flex-center">
             <!-- aca iria imagen de perfil -->
            
        </q-card-section>
      </q-card-section>

      <q-separator />

      <q-card-section>
        Esta es una previsualisacion del perfil que se generaria
      </q-card-section>
    </q-card>
  </div>
    </div>
  </q-page>
</template>

<script>


import { defineComponent, ref } from "vue";
import { useQuasar } from "quasar";
import { useRoute } from "vue-router";
import QRious from "qrious";


export default {
    methods:{
    generateQrCode: function(){
    
    if (this.nombre != "" && this.nombre != "\n" && this.nombre != null) {
        this.isHidden=true
        console.log(this.nombre)
        new QRious({
                level: "H",
                padding: 25,
                size: 300,
                element: document.getElementById("qr-code"),
                value: this.nombre,
              });
          }
    },
    
  },

  components: {

  },
  data() {
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
      isHidden:false,
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
};
</script>


<style scoped>
.wave {
  position: fixed;
  height: 100%;
  left: 0;
  bottom: 0;
  z-index: -1;
}

.titulo-card{
  position: relative;
  color: white;
  background: radial-gradient(circle, #6ba577 0%, #c7bb77 100%);
  top: 5px;
  left: 10px;
  width: 100%;
  max-width: 250px;
  right: 1;
  z-index: -1;
}

</style>


