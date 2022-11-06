<template>
  <div class="q-pa-md q-gutter-sm">
    <q-dialog v-model="toolbar">
      <q-card>
        <q-toolbar>
          <q-space />
          <q-btn color="purple" round dense icon="close" v-close-popup />
        </q-toolbar>
        <q-card-section>
          <AddPersonal />
        </q-card-section>
      </q-card>
    </q-dialog>

    <q-dialog v-model="confirm" persistent>
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar icon="priority_high" color="red" text-color="white" />
          <span class="q-ml-sm">
            Esta seguro de eliminar el id: {{ idelim }} ?
          </span>
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
        title="Personal"
        :rows="rows"
        :columns="columns"
        row-key="id"
        :filter="filter"
        binary-state-sort
      >
        <template v-slot:top>
          <div class="col-2 q-table__title">Personal</div>
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
              />
            </q-td>

            <q-td key="id" :props="props">
              {{ props.row.id }}
            </q-td>
            <q-td key="nroDocumento" :props="props">
              <div class="text-pre-wrap">{{ props.row.nroDocumento }}</div>
              <q-popup-edit
                v-model="props.row.nroDocumento"
                v-slot="scope"
                title="Nro Doc"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'nroDocumento');
                  }
                "
              >
                <q-input type="number" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <q-td key="apellido" :props="props">
              <div class="text-pre-wrap">{{ props.row.apellido }}</div>
              <q-popup-edit
                v-model="props.row.apellido"
                v-slot="scope"
                title="Apellido"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'apellido');
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
              </q-popup-edit>
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
            <q-td key="fechaNacimiento" :props="props">
              <div class="text-pre-wrap">{{ props.row.fechaNacimiento }}</div>
              <q-popup-edit
                v-model="props.row.fechaNacimiento"
                v-slot="scope"
                title="Fecha Nacimiento"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'fechaNacimiento');
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <q-td key="email" :props="props">
              <div class="text-pre-wrap">{{ props.row.email }}</div>
              <q-popup-edit
                v-model="props.row.email"
                v-slot="scope"
                title="Email"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'email');
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <q-td key="celular" :props="props">
              <div class="text-pre-wrap">{{ props.row.celular }}</div>
              <q-popup-edit
                v-model="props.row.celular"
                v-slot="scope"
                title="Celular"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'celular');
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <q-td key="domicilio" :props="props">
              <div class="text-pre-wrap">{{ props.row.domicilio }}</div>
              <q-popup-edit
                v-model="props.row.domicilio"
                v-slot="scope"
                title="Domicilio"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'domicilio');
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <q-td key="barrio" :props="props">
              <div class="text-pre-wrap">{{ props.row.barrio }}</div>
              <q-popup-edit
                v-model="props.row.barrio"
                v-slot="scope"
                title="Barrio"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'barrio');
                  }
                "
              >
                <q-input type="text" v-model="scope.value" dense autofocus />
              </q-popup-edit>
            </q-td>
            <q-td key="localidadId" :props="props">
              <div class="text-pre-wrap">
                {{ props.row.Localidad.nombre }}
              </div>
              <!--       <q-popup-edit
                v-model="Localidad"
                v-slot="scope"
                title="Localidad"
                buttons
                label-set="Guardar"
                label-cancel="Cancelar"
                @save="
                  (v, iv) => {
                    save(v, iv, props.key, 'localidadId');
                  }
                " 
              >  -->
              <!--  <q-input type="text" v-model="scope.value" dense autofocus /> -->
              <!--        <q-select v-model="scope.value" filled autofocus />
              </q-popup-edit> -->
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
import AddPersonal from "src/components/personal/AddPersonal.vue";

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
    name: "nroDocumento",
    align: "center",
    label: "Nro Dcoc",
    field: "nroDocumento",
    sortable: true,
  },
  {
    name: "apellido",
    align: "center",
    label: "Apellido",
    field: "apellido",
    sortable: true,
  },
  {
    name: "nombre",
    align: "center",
    label: "Nombre",
    field: "nombre",
    sortable: true,
  },
  {
    name: "fechaNacimiento",
    align: "center",
    label: "Fecha Nac",
    field: "fechaNacimiento",
    sortable: true,
  },
  {
    name: "email",
    align: "center",
    label: "Email",
    field: "email",
    sortable: true,
  },
  {
    name: "celular",
    align: "center",
    label: "Celular",
    field: "celular",
    sortable: true,
  },
  {
    name: "domicilio",
    align: "center",
    label: "Domicilio",
    field: "domicilio",
    sortable: true,
  },
  {
    name: "barrio",
    align: "center",
    label: "barrio",
    field: "barrio",
    sortable: true,
  },
  {
    name: "localidadId",
    align: "center",
    label: "localidadId",
    field: "localidadId",
    sortable: true,
  },
];

export default {
  setup() {
    const $q = useQuasar();
    const data = ref([]);
    const localidades = ref([]);
    function returnPersonal() {
      api
        .get("personal", {
          headers: {
            accept: "application/json",
          },
        })
        .then((response) => {
          data.value = response.data;
          console.log(`data  ${JSON.stringify(data.value)}`);
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
    function returnLocalidades() {
      api
        .get("/localidad", {
          headers: {
            accept: "application/json",
          },
        })
        .then((response) => {
          localidades.value = response.data;
          console.log(`localidades  ${JSON.stringify(localidades.value)}`);
        })
        .catch((error) => {
          console.log(`error ${error}`);
          $q.notify({
            color: "negative",
            position: "bottom",
            message: `code: ${error.response.status} - Mensaje ${error}`,
            icon: "report_problem",
          });
        });
    }

    onMounted(() => {
      returnPersonal();
      returnLocalidades();
    });
    return {
      filter: ref(""),
      save(value, initialValue, id, field) {
        const personal = `{ "${field}": "${value}"  }`;
        api
          .put(`/personal/${id}`, JSON.parse(personal), {
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
          .delete(`/personal/${id}`, {
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
            returnPersonal();
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
      localidades,
      confirm: ref(false),
      verturno: ref(false),
      toolbar: ref(false),
      idelim: ref(0),
      sendTurno: ref([]),
    };
  },
  components: { AddPersonal },
};
</script>
