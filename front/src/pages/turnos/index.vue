<template>
  <div class="q-pa-md q-gutter-sm">
    <q-dialog @hide="returnTurnos" v-model="toolbar">
      <q-card>
        <q-toolbar>
          <q-space />
          <q-btn color="purple" round dense icon="close" v-close-popup />
        </q-toolbar>
        <q-card-section>
          <AddTurno />
        </q-card-section>
      </q-card>
    </q-dialog>
    <q-dialog v-model="confirm" persistent>
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar icon="priority_high" color="red" text-color="white" />
          <span class="q-ml-sm"
            >Esta seguro de eliminar el id: {{ idelim }} ?</span
          >
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="red" v-close-popup />
          <q-btn
            flat
            label="Confirmar"
            color="primary"
            @click="eliminar(idelim)"
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
        title="Turnos"
        :rows="rows"
        :columns="columns"
        row-key="id"
        :filter="filter"
        binary-state-sort
      >
        <template v-slot:top>
          <div class="col-2 q-table__title">Turnos</div>
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
                @click="(confirm = !confirm), (idelim = props.key)"
                icon="delete"
            /></q-td>

            <q-td key="id" :props="props">
              {{ props.row.id }}
            </q-td>
            <q-td key="nombre" :props="props">
              <div class="text-pre-wrap">{{ props.row.nombre }}</div>
              <q-popup-edit
                v-model="props.row.nombre"
                v-slot="scope"
                title="Nombre"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'nombre');
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <q-td key="descripcion" :props="props">
              {{ props.row.descripcion }}
              <q-popup-edit
                v-model="props.row.descripcion"
                v-slot="scope"
                title="Descripcion"
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
import AddTurno from "../../components/turno/AddTurno.vue";

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
    name: "nombre",
    align: "center",
    label: "Nombre Turnos",
    field: "nombre",
    sortable: true,
  },
  {
    name: "descripcion",
    label: "Descripcion",
    field: "descripcion",
    sortable: true,
    // style: "width: 10px",
  },
];

export default {
  setup() {
    const $q = useQuasar();
    const data = ref([]);
    function returnTurnos() {
      api
        .get("turno", {
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
      returnTurnos();
    });
    return {
      filter: ref(""),
      save(value, initialValue, id, field) {
        const turno = `{ "${field}": "${value}"  }`;
        api
          .put(`/turno/${id}`, JSON.parse(turno), {
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
          .delete(`/turno/${id}`, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            $q.notify({
              color: "positive",
              position: "bottom",
              message: `Se elimino el usuario id: ${this.idelim.value} correctamente`,
              icon: "mood",
            });
            returnTurnos();
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
      verturno: ref(false),
      toolbar: ref(false),
      idelim: ref(0),
      sendTurno: ref([]),
      returnTurnos,
    };
  },
  components: { AddTurno },
};
</script>
