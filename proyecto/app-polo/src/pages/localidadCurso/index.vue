<template>
  <div class="q-pa-md q-gutter-sm">
    <q-dialog v-model="toolbar">
      <q-card>
        <q-toolbar>
          <q-space />
          <q-btn color="purple" round dense icon="close" v-close-popup />
        </q-toolbar>
        <q-card-section>
          <add-localidad-curso />
        </q-card-section>
      </q-card>
    </q-dialog>
    <q-dialog v-model="confirm" persistent>
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar icon="priority_high" color="red" text-color="white" />
          <span class="q-ml-sm">
            Esta seguro de eliminar el cursoid: {{ idCursoKey }} y localidadId
            {{ idLocalidadKey }}?
          </span>
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="red" v-close-popup />
          <q-btn
            flat
            label="Confirmar"
            color="primary"
            @click="eliminar(idCursoKey, idLocalidadKey)"
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
          <div class="col-2 q-table__title">Curso Localidad</div>
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
            <q-td auto-width>
              <q-btn
                size="sm"
                round
                color="red"
                glossy
                @click="
                  (confirm = !confirm),
                    (idCursoKey = props.row.cursoId),
                    (idLocalidadKey = props.row.localidadId)
                "
                icon="delete"
            /></q-td>
            <q-td key="nombreMostrar" :props="props">
              <div class="text-pre-wrap">{{ props.row.nombreMostrar }}</div>
            </q-td>

            <q-td key="cursoId" :props="props">
              <div class="text-pre-wrap">
                {{ props.row.Curso.nombre }}
              </div>
            </q-td>
            <q-td key="localidadId" :props="props">
              <div class="text-pre-wrap">
                {{ props.row.Localidad.nombre }}
              </div>
            </q-td>
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
                    save(v, iv, props.key, 'descripcion');
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
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
import { ref, onMounted } from "vue";
import { useQuasar } from "quasar";
import AddLocalidadCurso from "../../components/localidadCurso/AddLocalidadCurso.vue";

const columns = [
  /*   {
    name: "id",
    required: true,
    label: "Id",
    align: "left",
    field: (row) => row.name,
    format: (val) => `${val}`,
    sortable: true,
  }, */
  {
    name: "nombreMostrar",
    align: "center",
    label: "Nombre Mostrar",
    field: "nombreMostrar",
    sortable: true,
  },

  {
    name: "cursoId",
    align: "center",
    label: "Curso",
    field: "cursoId",
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
    name: "descripcion",
    align: "center",
    label: "Descripcion",
    field: "descripcion",
    sortable: true,
  },
];

export default {
  setup() {
    const $q = useQuasar();
    const data = ref([]);
    function returnCursoDestinatario() {
      api
        .get("LocalidadOnCurso?select=*, Curso(nombre),Localidad(nombre)", {
          headers: {
            accept: "application/json",
          },
        })
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
      returnCursoDestinatario();
    });
    return {
      filter: ref(""),
      save(value, initialValue, id, field) {
        const curso = `{ "${field}": "${value}"  }`;
        api
          .patch(`LocalidadOnCurso?id=eq.${id}`, JSON.parse(curso), {
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
      eliminar(idCurso, idDestinatario) {
        api
          .delete(
            `LocalidadOnCurso?cursoId=eq.${idCurso}&localidadId=eq.${idDestinatario}`,
            {
              headers: {
                accept: "application/json",
              },
            }
          )
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se elimino el Curso id: ${this.idCursoKey.value}, Destinatario: ${this.idLocalidadKey.value} correctamente`,
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
      idLocalidadKey: ref(0),
    };
  },
  components: { AddLocalidadCurso },
};
</script>
