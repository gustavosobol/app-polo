<template>
  <div class="q-pa-md">
    <q-dialog v-model="prompt" persistent>
      <q-card style="min-width: 350px">
        <q-card-section>
          <div class="text-h6">Curso seleccionado: {{ actual }}</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          <q-input
            dense
            label="Ingrese Nro Documento"
            v-model="doc"
            autofocus
            type="number"
            :rules="[
              (val) =>
                (val !== null && val !== '') ||
                'Ingrese su número de documento',
              (val) => val.length >= 7 || 'El numero debe ser valido',
            ]"
            @keyup.enter="
              $router.push({
                name: 'SearchAlumnos',
                params: {
                  idCurso: idCurso,
                  nombreCurso: actual,
                  idAlumno: doc,
                },
              }),
                (prompt = false)
            "
          />
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn flat label="Cancelar" v-close-popup />
          <router-link
            :to="{
              name: 'SearchAlumnos',
              params: {
                idCurso: idCurso,
                nombreCurso: actual,
                idAlumno: doc,
              },
            }"
            style="text-decoration: none"
          >
            <q-btn color="primary" v-close-popup>Verificar</q-btn>
          </router-link>
        </q-card-actions>
      </q-card>
    </q-dialog>
    <q-card class="my-card">
      <q-item>
        <q-item-section avatar>
          <q-avatar>
            <img src="~assets/boy-avatar.png" />
          </q-avatar>
        </q-item-section>
        <q-item-section
          ><div class="text-h6">{{ LocalidadOnCurso.Curso.nombre }}</div>
          <div class="text-subtitle2">
            {{ LocalidadOnCurso.Localidad.nombre }}
          </div>
        </q-item-section>
      </q-item>

      <q-tabs v-model="tab" class="text-teal">
        <q-tab label="Horarios" name="horario" />
        <q-tab label="Descripción" name="descripcion" />
      </q-tabs>

      <q-separator />

      <q-tab-panels v-model="tab" animated>
        <q-tab-panel name="horario">
          <div>
            <div>Fecha Inicio: {{ fechaInicio }} Fin: {{ fechaFin }}</div>
          </div>
          <div>
            <div>Dias:Me faltan los dias</div>
            <div>Horarios: {{ horario }}</div>
          </div>
          <div>
            <div>Cupos: {{ cupos }}</div>
          </div>
        </q-tab-panel>

        <q-tab-panel name="descripcion">
          descripcion: {{ descripcion }}
        </q-tab-panel>
      </q-tab-panels>

      <q-separator />
      <q-card-section>
        <div class="text-h6">Profesor: Falta</div>
        <div class="q-pa-md column q-gutter-sm">
          <q-btn
            flat
            rounded
            color="primary"
            label="Reservar"
            @click="
              (prompt = true), (actual = String(nombreMostrar)), (idCurso = id)
            "
          />
        </div>
      </q-card-section>
    </q-card>
  </div>
</template>
<script>
import { defineComponent, ref } from "vue";

export default defineComponent({
  setup() {
    let actual = "0";
    let idCurso = ref(null);
    let doc = ref();
    return {
      tab: ref("horario"),
      actual,
      idCurso,
      doc,
      prompt: ref(false),
    };
  },
  props: {
    id: {
      type: Number,
      // default: "",
    },
    nombreMostrar: {
      type: String,
      default: "nombre",
    },
    fechaInicio: {
      type: String,
      default: "",
    },
    fechaFin: {
      type: String,
      default: "",
    },
    horario: {
      type: String,
      default: "",
    },
    cupos: {
      type: Number,
      // default: "",
    },
    descripcion: {
      type: String,
      default: "apellido",
    },
    Salas: {
      type: Object,
      //default: "Object",
    },
    LocalidadOnCurso: {
      type: Object,
      //default: "Object",
    },
    /*     Localidad: {
      type: Object,
      // default: LocalidadOnCurso,
    }, */
  },
});
</script>

<style lang="sass" scoped>
.my-card
  width: 100%
  max-width: 250px
</style>
