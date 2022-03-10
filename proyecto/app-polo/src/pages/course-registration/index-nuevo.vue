<template>
  <div class="q-pa-md">
    <pre>tabla {{ rows }}</pre>
    <q-dialog v-model="prompt" persistent>
      <q-card style="min-width: 350px">
        <q-card-section>
          <div class="text-h6">Curso seleccionado: {{ actual }}</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          <q-input
            dense
            v-model="doc"
            autofocus
            @keyup.enter="
              $router.push({
                name: 'Alumnos',
                params: { idCurso: actual, idAlumno: doc },
              }),
                (prompt = false)
            "
          />
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn flat label="Cancelar" v-close-popup />
          <router-link
            :to="{
              name: 'Alumnos',
              params: { idCurso: actual, idAlumno: doc },
            }"
            style="text-decoration: none"
          >
            <q-btn color="primary" v-close-popup>Verificar</q-btn>
          </router-link>
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-table
      title="Lista Cursos Activos"
      :rows="rows"
      :columns="columns"
      row-key="id"
      v-model:pagination="pagination"
      :loading="loading"
      :filter="filter"
      @request="onRequest"
      binary-state-sort
      :visible-columns="visibleColumns"
    >
      <template v-slot:top-right="props">
        <q-input
          borderless
          dense
          debounce="300"
          v-model="filter"
          placeholder="Buscar"
        >
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
        <q-btn
          flat
          round
          dense
          :icon="props.inFullscreen ? 'fullscreen_exit' : 'fullscreen'"
          @click="props.toggleFullscreen"
          class="q-ml-md"
        />
      </template>
      <template v-slot:header="props">
        <q-tr :props="props">
          <q-th auto-width />
          <q-th auto-width />
          <q-th
            v-for="col in props.cols"
            :key="col.nombreMostrar"
            :props="props"
          >
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
              color="primary"
              glossy
              @click="props.expand = !props.expand"
              :icon="props.expand ? 'visibility_off' : 'visibility'"
            />
          </q-td>
          <q-td auto-width>
            <q-btn
              size="sm"
              round
              color="amber"
              glossy
              text-color="black"
              icon="school"
              @click="
                (prompt = true), (actual = String(props.row.nombreMostrar))
              "
            />
          </q-td>
          <q-td
            v-for="col in props.cols"
            :key="col.nombreMostrar"
            :props="props"
          >
            {{ col.value }}
          </q-td>
        </q-tr>
        <q-tr v-show="props.expand" :props="props">
          <q-td colspan="100%">
            <div class="text-left">
              Localidad: {{ props.row.LocalidadOnCurso }}
            </div>
            <div class="text-left">
              Descripcion: {{ props.row.descripcion }}
            </div>
          </q-td>
        </q-tr>
      </template>
    </q-table>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";

import { api } from "boot/axios";
const columns = [
  { name: "id", align: "center", label: "id", field: "id", sortable: true },
  {
    name: "nombreMostrar",
    required: true,
    label: "Nombre de Curso",
    align: "left",
    // field: 'nombre',
    field: (row) => row.nombreMostrar,
    format: (val) => `${val.toUpperCase()}`,
    sortable: true,
  },
  /*   {
    name: "destinatarioNombre",
    align: "center",
    label: "Edades",
    field: "destinatarioNombre",
    sortable: true,
  }, */
  {
    name: "fechaInicio",
    label: "Inicio",
    field: "fechaInicio",
    sortable: true,
  },
  { name: "fechaFin", label: "Fin", field: "fechaFin", sortable: true },
  { name: "horario", label: "Horario", field: "horario", sortable: true },
  { name: "cupos", label: "Cupos", field: "cupos", sortable: true },
  {
    name: "descripcion",
    label: "Descripcion",
    field: "descripcion",
    sortable: true,
    sort: (a, b) => parseInt(a, 10) - parseInt(b, 10),
  },
  {
    name: "LocalidadOnCurso",
    label: "Localidad",
    field: "LocalidadOnCurso",
    sortable: true,
    sort: (a, b) => parseInt(a, 10) - parseInt(b, 10),
  },
];
const originalRows = [];
export default {
  setup() {
    let actual = "0";
    let doc = ref();
    const rows = ref([]);
    const filter = ref("");
    const loading = ref(false);
    const pagination = ref({
      sortBy: "desc",
      descending: false,
      page: 1,
      rowsPerPage: 10,
      rowsNumber: 10,
    });

    function allCursos() {
      api
        .get(
          `/CursosActivos?or=(nombreMostrar.like.**)&select=*,LocalidadOnCurso(nombreMostrar),Salas(nombre)`,
          {
            headers: {
              accept: "application/json",
              //  Authorization: token,
            },
          }
        )
        .then((response) => {
          //console.log("datos " + JSON.stringify(response.data));
          originalRows.value = JSON.stringify(response.data);
          console.log("datos " + originalRows.value);
          return JSON.stringify(response.data.data);
        });
    }
    ///// onMounted(() => {});
    async function callEndpoints() {
      console.log(this.$routes);
    }
    //router.push({name: 'Alumnos', params: {idCurso: actual, idAlumno: doc } })
    // emulate ajax call
    // SELECT * FROM ... WHERE...LIMIT...
    function fetchFromServer(startRow, count, filter, sortBy, descending) {
      const data = filter
        ? //  ? originalRows.filter(row => row.name.toUpperCase().includes(filter.toUpperCase()))
          originalRows.filter((row) =>
            (row.nombre.toUpperCase() + row.id).includes(filter.toUpperCase())
          )
        : originalRows.slice();
      console.log(`fetch`);
      // handle sortBy
      if (sortBy) {
        const sortFn =
          sortBy === "desc"
            ? descending
              ? (a, b) =>
                  a.nombre > b.nombre ? -1 : a.nombre < b.nombre ? 1 : 0
              : (a, b) =>
                  a.nombre > b.nombre ? 1 : a.nombre < b.nombre ? -1 : 0
            : descending
            ? (a, b) => parseFloat(b[sortBy]) - parseFloat(a[sortBy])
            : (a, b) => parseFloat(a[sortBy]) - parseFloat(b[sortBy]);
        data.sort(sortFn);
      }

      return data.slice(startRow, startRow + count);
    }

    // emulate 'SELECT count(*) FROM ...WHERE...'
    function getRowsNumberCount(filter) {
      console.log(`getRowsNumberCount`);
      if (!filter) {
        return originalRows.length;
      }
      let count = 0;
      originalRows.forEach((treat) => {
        if (treat.nombre.includes(filter)) {
          ++count;
        }
      });
      return count;
    }

    function onRequest(props) {
      console.log(`onRequest`);

      const { page, rowsPerPage, sortBy, descending } = props.pagination;
      const filter = props.filter;

      loading.value = true;

      // emulate server
      setTimeout(() => {
        // update rowsCount with appropriate value
        pagination.value.rowsNumber = getRowsNumberCount(filter);

        // get all rows if "All" (0) is selected
        const fetchCount =
          rowsPerPage === 0 ? pagination.value.rowsNumber : rowsPerPage;

        // calculate starting row of data
        const startRow = (page - 1) * rowsPerPage;

        // fetch data from "server"
        const returnedData = fetchFromServer(
          startRow,
          fetchCount,
          filter,
          sortBy,
          descending
        );

        // clear out existing data and add new
        rows.value.splice(0, rows.value.length, ...returnedData);

        // don't forget to update local pagination object
        pagination.value.page = page;
        pagination.value.rowsPerPage = rowsPerPage;
        pagination.value.sortBy = sortBy;
        pagination.value.descending = descending;

        // ...and turn of loading indicator
        loading.value = false;
      }, 1500);
    }

    onMounted(() => {
      allCursos();
      // get initial data from server (1st page)
      onRequest({
        pagination: pagination.value,
        filter: undefined,
      });
    });

    return {
      // variables propias
      doc,
      actual,
      // requerido de los completos
      filter,
      loading,
      pagination,
      columns,
      rows,
      visibleColumns: ref([
        "id",
        "nombre",
        "destinatarioNombre",
        "fechaInicio",
        "fechaFin",
        "horario",
      ]),
      onRequest,
      prompt: ref(false),
      callEndpoints,
    };
  },
};
</script>
