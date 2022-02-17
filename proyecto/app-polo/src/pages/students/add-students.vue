<template>
  <q-page>
    <div class="row q-col-gutter-sm q-ma-xs">
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <q-card>
          <q-card-section>
            <q-form class="q-gutter-md">
              <!-- comienza card1 -->

              <div class="text-h6">Agregar Alumno</div>
              <div class="text-caption text-grey">
                Ingrese los campos para registrar al alumno
              </div>

              <InputsFormulario />
            </q-form>
          </q-card-section>
        </q-card>
      </div>

      <!-- comienza card2 -->
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <q-card class="my-card" flat bordered>
          <q-card-section horizontal>
            <q-card-section class="q-pt-xs">
              <div class="text-overline">Perfil</div>
              <div class="text-h5 q-mt-sm q-mb-xs">
                {{ name }} {{ apellido }}
              </div>

              <div class="text-caption text-grey">Edad: {{ date }}</div>
              <div class="text-caption text-grey">
                Telefono: {{ numero_tel }}
              </div>
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
    </div>
  </q-page>
</template>

<script>
import { useQuasar } from "quasar";
import { ref } from "vue";
import { useRoute } from "vue-router";
import InputsFormulario from "../../components/inputs-formulario.vue";

export default {
  components: {
    InputsFormulario,
  },
  setup() {
    return {};
  },
};
</script>

<style scoped></style>
