<template>
  <div class="q-pa-md q-gutter-sm">
    <q-dialog @hide="returnCursoDestinatario" v-model="toolbar">
      <q-card>
        <q-toolbar>
          <q-space />
          <q-btn color="purple" round dense icon="close" v-close-popup />
        </q-toolbar>
        <q-card-section>
          <add-curso-activos />
        </q-card-section>
      </q-card>
    </q-dialog>
    <q-dialog v-model="confirm" persistent>
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar icon="priority_high" color="red" text-color="white" />
          <span class="q-ml-sm">
            Esta seguro de eliminar el Curso Activo: {{ id }}?
          </span>
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="red" v-close-popup />
          <q-btn
            flat
            label="Confirmar"
            color="primary"
            @click="eliminar(id)"
            v-close-popup
          />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <div class="q-pa-md">
      <q-btn
        class="q-mb-md"
        round
        color="purple"
        icon="add"
        @click="toolbar = true"
      />
      <q-table
        title="Curso Detalle"
        :rows="rows"
        :columns="columns"
        row-key="id"
        :filter="filter"
        binary-state-sort
      >
        <template v-slot:top>
          <div class="col-2 q-table__title">Cursos Activos</div>
          <q-space />
          <q-input
            borderless
            dense
            debounce="300"
            v-model="filter"
            placeholder="Search"
          >
            <template v-slot:append>
              <q-icon name="search" />
            </template>
          </q-input>
        </template>
        <template v-slot:header="props">
          <q-tr :props="props">
            <q-th auto-width />
            <q-th v-for="col in props.cols" :key="col.name" :props="props">
              {{ col.label }}
            </q-th>
          </q-tr>
        </template>
        <template v-slot:body="props">
          <q-tr :props="props">
            <!-- Eliminar -->
            <q-td auto-width>
              <q-btn
                size="sm"
                round
                color="red"
                glossy
                @click="(confirm = !confirm), (id = props.key)"
                icon="delete"
              />
            </q-td>
            <!-- id -->
            <q-td key="id" :props="props">
              {{ props.row.id }}
            </q-td>
            <!-- activo -->
            <q-td key="activo" :props="props">
              <q-toggle
                v-model="props.row.activo"
                @click="cursoActivo(props.row.id, props.row.activo)"
                color="green"
              />
            </q-td>
            <!-- nombre mostrar -->
            <q-td key="nombreMostrar" :props="props">
              <div class="text-pre-wrap">{{ props.row.nombreMostrar }}</div>
            </q-td>
            <!-- Fecha inicio -->
            <q-td key="fechaInicio" :props="props">
              <div class="text-pre-wrap">{{ props.row.fechaInicio }}</div>
              <q-popup-edit
                v-model="props.row.fechaInicio"
                v-slot="scope"
                title="Descripción"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'fechaInicio');
                  }
                "
              >
                <q-date v-model="scope.value" mask="YYYY-MM-DD" minimal />
                <!--                 <q-input type="text" v-model="scope.value" dense autofocus />
 -->
              </q-popup-edit>
            </q-td>
            <!-- Fecha Fin -->
            <q-td key="fechaFin" :props="props">
              <div class="text-pre-wrap">{{ props.row.fechaFin }}</div>
              <q-popup-edit
                v-model="props.row.fechaFin"
                v-slot="scope"
                title="Descripción"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'fechaFin');
                  }
                "
              >
                <q-date v-model="scope.value" mask="YYYY-MM-DD" minimal />
              </q-popup-edit>
            </q-td>
            <!-- Cupos -->
            <q-td key="cupos" :props="props">
              <div class="text-pre-wrap">{{ props.row.cupos }}</div>
              <q-popup-edit
                v-model="props.row.cupos"
                v-slot="scope"
                title="Descripción"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'cupos');
                  }
                "
              >
                <q-input type="number" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <!-- Salas -->
            <q-td key="salaId" :props="props">
              <q-select
                disable
                v-model="props.row.Salas.nombre"
                :options="listaSalas"
                option-value="id"
                option-label="nombre"
                behavior="menu"
                :rules="[
                  (val) => val !== null || 'Debe seleccionar una localidad',
                ]"
              />
              <q-popup-edit
                v-model="props.row.Salas.nombre"
                v-slot="scope"
                title="Descripción"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v.id, iv, props.key, 'salaId');
                  }
                "
              >
                <!--                 <q-input type="number" v-model="scope.value" dense autofocus />
 -->
                <!-- Salas -->
                <q-select
                  v-model="scope.value"
                  :options="listaSalas"
                  option-value="id"
                  option-label="nombre"
                  label="Salas"
                  behavior="menu"
                  :rules="[
                    (val) => val !== null || 'Debe seleccionar una localidad',
                  ]"
                />
              </q-popup-edit>
            </q-td>
            <!-- Localidad -->
            <q-td key="localidadId" :props="props">
              <q-select
                disable
                v-model="props.row.LocalidadOnCurso.Localidad.nombre"
                :options="listaLocalidades"
                option-value="id"
                option-label="nombre"
                behavior="menu"
                :rules="[
                  (val) => val !== null || 'Debe seleccionar una localidad',
                ]"
              />
              <q-popup-edit
                v-model="props.row.LocalidadOnCurso.Localidad.nombre"
                v-slot="scope"
                title="Localidad"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v.id, iv, props.key, 'localidadId');
                  }
                "
              >
                <q-select
                  v-model="scope.value"
                  :options="listaLocalidades"
                  option-value="id"
                  option-label="nombre"
                  label="Localidades"
                  behavior="menu"
                  :rules="[
                    (val) => val !== null || 'Debe seleccionar una localidad',
                  ]"
                />
              </q-popup-edit>
            </q-td>
            <!-- Turnos -->
            <q-td key="turnoId" :props="props">
              <q-select
                disable
                v-model="props.row.Turno.nombre"
                :options="listaTurno"
                option-value="id"
                option-label="nombre"
                behavior="menu"
                :rules="[
                  (val) => val !== null || 'Debe seleccionar una localidad',
                ]"
              />
              <q-popup-edit
                v-model="props.row.Turno.nombre"
                v-slot="scope"
                title="Turno"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v.id, iv, props.key, 'turnoId');
                  }
                "
              >
                <q-select
                  v-model="scope.value"
                  :options="listaTurno"
                  option-value="id"
                  option-label="nombre"
                  label="Turnos"
                  behavior="menu"
                  :rules="[
                    (val) => val !== null || 'Debe seleccionar una localidad',
                  ]"
                />
              </q-popup-edit>
            </q-td>
            <!-- descripcion -->
            <q-td key="descripcion" :props="props">
              <div class="text-pre-wrap">{{ props.row.descripcion }}</div>
              <q-popup-edit
                v-model="props.row.descripcion"
                v-slot="scope"
                title="Descripción"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(
                      v,
                      iv,
                      props.row.cursoId,
                      props.row.localidadId,
                      'descripcion'
                    );
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <!-- dia_horario -->
            <q-td key="dia_horario" :props="props">
              <div class="text-pre-wrap">{{ props.row.dia_horario }}</div>
              <q-popup-edit
                v-model="props.row.dia_horario"
                v-slot="scope"
                title="Descripción"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(
                      v,
                      iv,
                      props.row.cursoId,
                      props.row.localidadId,
                      'dia_horario'
                    );
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <!-- Curso -->
            <q-td key="cursoId" :props="props">
              <q-select
                disable
                v-model="props.row.LocalidadOnCurso.Curso.nombre"
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
              <q-popup-edit
                v-model="props.row.LocalidadOnCurso.Curso.nombre"
                v-slot="scope"
                title="Curso"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @show="filterFn(props.row.LocalidadOnCurso.localidadId)"
                @save="
                  (v, iv) => {
                    save(v.cursoId, iv, props.key, 'cursoId');
                  }
                "
              >
                <q-select
                  v-model="scope.value"
                  :options="listaCurso"
                  option-value="cursoId"
                  option-label="nombreMostrar"
                  label="Tipo Cursos"
                  use-input
                  behavior="menu"
                  :rules="[
                    (val) => val !== null || 'Debe seleccionar una localidad',
                  ]"
                />
              </q-popup-edit>
            </q-td>
          </q-tr>
        </template>
      </q-table>
    </div>
  </div>
</template>
<script>
import { api } from "boot/axios";
import { ref, defineComponent, onMounted } from "vue";
import { useQuasar } from "quasar";
import AddCursoActivos from "../../components/cursoActivos/AddCursoActivos.vue";

const columns = [
  {
    name: "id",
    required: true,
    label: "Id",
    align: "left",
    field: (row) => row.name,
    format: (val) => `${val}`,
    sortable: true,
  },
  {
    name: "activo",
    align: "center",
    label: "Activo",
    field: "activo",
    sortable: true,
  },
  {
    name: "nombreMostrar",
    align: "center",
    label: "Nombre Curso",
    field: "nombreMostrar",
    sortable: true,
  },
  {
    name: "fechaInicio",
    align: "center",
    label: "Fecha Inicio",
    field: "fechaInicio",
    sortable: true,
  },

  {
    name: "fechaFin",
    align: "center",
    label: "Fecha fin",
    field: "fechaFin",
    sortable: true,
  },
  {
    name: "cupos",
    align: "center",
    label: "Cupos",
    field: "cupos",
    sortable: true,
  },
  {
    name: "salaId",
    align: "center",
    label: "Sala",
    field: "salaId",
    sortable: true,
  },
  {
    name: "localidadId",
    align: "center",
    label: "Localidad",
    field: "localidadId",
    sortable: true,
  },
  {
    name: "turnoId",
    align: "center",
    label: "Turno",
    field: "turnoId",
    sortable: true,
  },
  {
    name: "descripcion",
    align: "center",
    label: "Descripcion",
    field: "descripcion",
    sortable: true,
  },
  {
    name: "dia_horario",
    align: "center",
    label: "Dia horario",
    field: "dia_horario",
    sortable: true,
  },
  {
    name: "cursoId",
    align: "center",
    label: "Curso",
    field: "cursoId",
    sortable: true,
  },
];

export default defineComponent({
  name: "IndexCursoActivos",
  setup() {
    const $q = useQuasar();

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
    /* Datos Cursos Activos */
    const data = ref([]);
    function returnCursoDestinatario() {
      api
        .get(
          "CursosActivos?select=*, Salas(nombre), LocalidadOnCurso(*, Localidad(nombre), Curso(nombre)), Turno(nombre) ",
          {
            headers: {
              accept: "application/json",
            },
          }
        )
        .then((response) => {
          data.value = response.data;
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
      returnCurso();
      returnLocalidades();
      returnCursoDestinatario();
      returnSalas();
    });
    let options = ref([]);
    return {
      filterFn(val, update) {
        options.value = curso.value;

        if (val === "") {
          update(() => {
            options.value = curso.value;

            // here you have access to "ref" which
            // is the Vue reference of the QSelect
          });
          return;
        }

        var update = function () {
          options.value = options.value.filter((v) => v.localidadId === val);
        };
        update();
      },
      filter: ref(""),

      cursoActivo(id, valor) {
        const curso = `{ "activo": "${valor}"  }`;
        api
          .patch(`CursosActivos?id=eq.${id}`, JSON.parse(curso), {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se cambio el estado al curso`,
              icon: "mood",
            });
          })
          .catch((error) => {
            $q.notify({
              color: "negative",
              position: "bottom",
              message: `Mensaje ${error}`,
              icon: "report_problem",
            });
          });
      },

      save(value, initialValue, id, field) {
        const curso = `{ "${field}": "${value}"  }`;
        api
          .patch(`CursosActivos?id=eq.${id}`, JSON.parse(curso), {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se guardo el campo: ${field} con el nuevo valor ${value} correctamente`,
              icon: "mood",
            });
          })
          .catch((error) => {
            $q.notify({
              color: "negative",
              position: "bottom",
              message: `Mensaje ${error}`,
              icon: "report_problem",
            });
          });
      },
      eliminar(id) {
        api
          .delete(`CursosActivos?id=eq.${id}`, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se elimino el Curso id: ${this.idCursoKey.value}, Destinatario: ${this.idDestinatarioKey.value} correctamente`,
              icon: "mood",
            });
            returnCursoDestinatario();
          })
          .catch((error) => {
            $q.notify({
              color: "negative",
              position: "bottom",
              message: `Mensaje ${error}`,
              icon: "report_problem",
            });
          });
      },

      columns,
      rows: ref(data),
      data,
      confirm: ref(false),
      toolbar: ref(false),
      idCursoKey: ref(0),
      idDestinatarioKey: ref(0),

      listaSalas: salas,
      listaLocalidades: localidades,
      listaTurno: turno,
      listaCurso: options,
      returnCursoDestinatario,
    };
  },
  components: { AddCursoActivos },
});
</script>
