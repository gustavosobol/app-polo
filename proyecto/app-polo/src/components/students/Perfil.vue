<template>
  <q-card class="my-card" flat bordered>
    <q-card-section horizontal>
      <q-card-section class="q-pt-xs">
        <div class="text-overline">Perfil</div>
        <div class="text-h5 q-mt-sm q-mb-xs">
          <!-- {{ title }} - -->
          {{ nombre }}
          {{ apellido }}
        </div>

        <div class="text-caption text-grey">
          Edad:
          {{ fecha_nacimiento }}
        </div>
        <div class="text-caption text-grey">
          Telefono:
          {{ celular }}
        </div>

        <div class="text-caption text-grey">
          Vive en:
          {{ domicilio }}
        </div>
        <div class="text-caption text-grey">
          Mail en:
          {{ email }}
        </div>
        <h1 v-if="!isHidden">
          <q-btn
            color="primary"
            label="QR"
            @click="generateQrCode()"
            size="xl"
            id="qr-button"
          />
        </h1>
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
</template>
<script>
import QRious from "qrious";
import { defineComponent } from "vue";
export default defineComponent({
  setup() {
    const isHidden = false;
    return {
      isHidden,
    };
  },
  methods: {
    generateQrCode: function () {
      if (this.nombre != "" && this.nombre != "\n" && this.nombre != null) {
        this.isHidden = true;
        new QRious({
          level: "H",
          padding: 25,
          size: 300,
          element: document.getElementById("qr-code"),
          value:
            this.nombre +
            " - " +
            this.apellido +
            "\n correo electronico: " +
            this.email,
        });
      }
    },
  },
  props: {
    nombre: {
      type: String,
      default: "nombre",
    },
    apellido: {
      type: String,
      default: "apellido",
    },
    fecha_nacimiento: {
      type: String,
      default: "cuak ",
    },
    celular: {
      type: String,
      default: "apellido",
    },
    domicilio: {
      type: String,
      default: "apellido",
    },
    email: {
      type: String,
      default: "apellido",
    },
  },
});
</script>
