<template>
  <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
    <q-card class="my-card" flat bordered>
      <q-card-section horizontal>
        <q-card-section class="q-pt-xs">
          <div class="text-overline">Perfil</div>
          <div class="text-h5 q-mt-sm q-mb-xs">
            {{ title }} - {{ name }} {{ apellido }}
          </div>

          <div class="text-caption text-grey">Edad: {{ date }}</div>
          <div class="text-caption text-grey">Telefono: {{ numero_tel }}</div>
          <div class="text-caption text-grey">
            Telefono URGENCIAS: {{ numero_contacto }}
          </div>
          <div class="text-caption text-grey">
            Vive en: {{ domicilio }} , Barrio
          </div>
          <q-btn color="primary" label="QR" @click="generateQrCode()" size="xl" id="qr-button"/>
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
</template>
<script>
import { defineComponent } from "vue";
import QRious from "qrious";
export default defineComponent({
  methods:{
    generateQrCode: function(){
    if (this.name != "" && this.name != "\n" && this.name != null) {
        console.log(this.name)
        new QRious({
                level: "H",
                padding: 25,
                size: 300,
                element: document.getElementById("qr-code"),
                value: this.nombre,
              });
          }
    }
  },
  props: {
    title: {
      type: String,
      required: true,
    },
    apellido: {
      type: String,
      default: "Apellido",
    },
    name: {
      type: String,
      default: "",
    },
    
  },
  /*   setup() {
    const name ;
    const apellido ;
    const age ;
    const accept ;
    const numero_tel ;
    const numero_contacto ;
    const domicilio ;
    return {
      //FORMULARIOS
      name,
      age,
      accept,
      apellido,
      numero_tel,
      numero_contacto,
      domicilio,
    };
  }, */
});
</script>