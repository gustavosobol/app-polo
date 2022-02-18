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
        </q-card-section>

        <q-card-section class="col-5 flex flex-center">
          <q-img
            class="rounded-borders"
            src="https://cdn.quasar.dev/img/boy-avatar.png"
          />
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

export default defineComponent({
  props: {
    title: {
      type: String,
      required: true,
    },
    apellido: {
      type: String,
      default: "Apellido",
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
