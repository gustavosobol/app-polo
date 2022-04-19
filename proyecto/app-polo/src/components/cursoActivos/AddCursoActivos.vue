<template>
  <div class="full-width row wrap justify-center items-start content-start">
    <div class="column q-pa-lg">
      <q-card square class="shadow-24" style="width: 300px; height: 100%">
        <q-card-section class="bg-deep-purple-7">
          <h4 class="text-h5 text-white q-my-md">Nuevo Curso Activos</h4>
        </q-card-section>
        <q-card-section>
          <q-form class="q-px-sm q-pt-xl q-pb-lg">
            <!-- activo -->
            <q-checkbox left-label label="Activo" v-model="activo" />
            <!-- Fecha Inicio Fecha Fin -->
            <br />
            <div class="row">
              <div class="col-3">
                <q-btn icon="event" round color="primary">
                  <q-popup-proxy
                    cover
                    transition-show="scale"
                    transition-hide="scale"
                  >
                    <q-date v-model="date_desde_hasta" range>
                      <div class="row items-center justify-end q-gutter-sm">
                        <q-btn
                          label="Cancel"
                          color="primary"
                          flat
                          v-close-popup
                        />
                        <q-btn label="OK" color="primary" flat v-close-popup />
                      </div>
                    </q-date>
                  </q-popup-proxy>
                </q-btn>
              </div>
              <div class="col">
                <q-badge color="teal">
                  Fecha Desde: {{ date_desde_hasta.from }}
                  <br />
                  Fecha Hasta: {{ date_desde_hasta.to }}
                </q-badge>
              </div>
            </div>
            <br />
            <!-- Cupos -->
            <q-input
              filled
              type="number"
              v-model="cupos"
              label="Nro Cupos"
              lazy-rules
              :rules="[
                (val) => (val !== null && val !== '') || 'Ingrese un número ',
                (val) => val > 0 || 'Debe ingresar un número mayor a cero',
              ]"
            />
            <!-- Localidad -->
            <q-select
              v-model="localidadId"
              :options="listaLocalidades"
              option-value="id"
              option-label="nombre"
              label="Localidad"
              behavior="menu"
              @focus="cursoId = null"
              :rules="[
                (val) => val !== null || 'Debe seleccionar una localidad',
              ]"
            />
            <!-- Curso -->
            <q-select
              v-show="localidadId != null"
              v-model="cursoId"
              :options="listaCurso"
              option-value="cursoId"
              option-label="nombreMostrar"
              label="Tipo Cursos"
              use-input
              behavior="menu"
              @filter="filterFn"
              :rules="[
                (val) => val !== null || 'Debe seleccionar una localidad',
              ]"
            />
            <!-- Salas -->
            <q-select
              v-model="salaId"
              :options="listaSalas"
              option-value="id"
              option-label="nombre"
              label="Salas"
              behavior="menu"
              :rules="[
                (val) => val !== null || 'Debe seleccionar una localidad',
              ]"
            />
            <!-- Turnos -->
            <q-select
              v-model="turnoId"
              :options="listaTurno"
              option-value="id"
              option-label="nombre"
              label="Turnos"
              behavior="menu"
              :rules="[
                (val) => val !== null || 'Debe seleccionar una localidad',
              ]"
            />
            <!-- Descripcion -->
            <q-input
              square
              clearable
              v-model="descripcion"
              type="text"
              label="Descripcion"
            >
              <template v-slot:prepend>
                <q-icon name="price_change" />
              </template>
            </q-input>
            <!-- Dia y horario -->
            <q-input
              square
              clearable
              v-model="dia_horario"
              type="text"
              label="Dia y horario"
              :rules="[(val) => val !== null || 'Debe indicar dia y horarios']"
            >
              <template v-slot:prepend>
                <q-icon name="price_change" />
              </template>
            </q-input>
          </q-form>
        </q-card-section>
        <q-card-actions class="q-px-lg">
          <q-btn
            unelevated
            size="lg"
            color="purple-4"
            class="full-width text-white"
            label="Guardar"
            @click="addCursoActivo"
          />
        </q-card-actions>
      </q-card>
    </div>
  </div>
</template>
<script>
import { ref, defineComponent, onMounted } from "vue";
import { api } from "boot/axios";
import { useQuasar, date } from "quasar";
export default defineComponent({
  name: "AddCursoActivos",
  setup() {
    /* Localidades */
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
    // curso
    const curso = ref([]);
    function returnCurso() {
      api
        .get("LocalidadOnCurso?vigente=eq.true", {
          headers: {
            accept: "application/json",
          },
        })
        .then((response) => {
          curso.value = response.data;
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
    /* Salas */
    const salas = ref([]);
    function returnSalas() {
      api
        .get("Salas", {
          headers: {
            accept: "application/json",
          },
        })
        .then((response) => {
          salas.value = response.data;
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
    /* Turnos */
    const turno = ref([]);
    function returnTurno() {
      api
        .get("Turno", {
          headers: {
            accept: "application/json",
          },
        })
        .then((response) => {
          turno.value = response.data;
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
      returnTurno();
      returnSalas();
      returnLocalidades();
      returnCurso();
    });
    const $q = useQuasar();
    const timeStamp = Date.now();
    const fechaInicio = ref(date.formatDate(timeStamp, "YYYY/MM/DD"));
    const fechaFin = ref(
      date.formatDate(date.addToDate(timeStamp, { days: 1 }), "YYYY/MM/DD")
    );
    const date_desde_hasta = ref({ from: fechaInicio, to: fechaFin });
    const activo = ref(true);
    const cupos = ref(0);
    const salaId = ref(null);
    const localidadId = ref(null);
    const turnoId = ref(null);
    const descripcion = ref(null);
    const dia_horario = ref(null);
    const cursoId = ref(null);
    const options = ref([]);

    return {
      filterFn(val, update) {
        options.value = curso.value;

        update(() => {
          options.value = options.value.filter(
            (v) => v.localidadId === localidadId.value.id
          );
        });
      },
      //add curso activo
      async addCursoActivo() {
        const cursoActivoNew = {
          activo: activo.value,
          fechaInicio: date_desde_hasta.value.from,
          fechaFin: date_desde_hasta.value.to,
          dia_horario: dia_horario.value,
          cupos: cupos.value,
          descripcion: descripcion.value,
          salaId: salaId.value.id,
          localidadId: localidadId.value.id,
          cursoId: cursoId.value.cursoId,
          turnoId: turnoId.value.id,
          nombreMostrar: `${cursoId.value.nombreMostrar}`,
        };
        console.log(`cursoActivoNew ${JSON.stringify(cursoActivoNew)}`);
        await api
          .post("CursosActivos", cursoActivoNew, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se creo el curso ${descripcion.value}`,
              icon: "mood",
            });
            return JSON.stringify(response.data);
          })
          .catch((error) => {
            console.log(`error ${error}`);
            $q.notify({
              color: "negative",
              position: "bottom",
              message: "No se pudo guardar el nuevo usuario",
              icon: "sentiment_very_dissatisfied",
            });
          });
      },

      activo,
      date_desde_hasta,
      cupos,
      descripcion,
      salaId,
      cursoId,
      localidadId,
      turnoId,
      dia_horario,

      listaLocalidades: localidades,
      listaCurso: options,
      listaSalas: salas,
      listaTurno: turno,
    };
  },
});
</script>
