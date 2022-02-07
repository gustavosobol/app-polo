<template>

  <div class="q-pa-md">
    <q-dialog v-model="prompt" persistent>
      <q-card style="min-width: 350px">
        <q-card-section>
          <div class="text-h6">Curso seleccionado: {{ actual }}</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          <q-input dense v-model="doc" autofocus @keyup.enter=" $router.push({ name: 'Alumnos', params: {idCurso: actual, idAlumno: doc }}), prompt = false" />
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn flat label="Cancelar"   v-close-popup />
          <router-link :to="{ name: 'Alumnos', params: {idCurso: actual, idAlumno: doc }}" style="text-decoration: none; ">
          <q-btn color="primary"  v-close-popup>Verificar</q-btn>
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
      <q-input borderless dense debounce="300" v-model="filter" placeholder="Buscar">
        <template v-slot:append>
          <q-icon name="search" />
        </template>
      </q-input>
      <q-btn
        flat round dense
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
          :key="col.name"
          :props="props"
        >
          {{ col.label }}
        </q-th>
      </q-tr>
    </template>

    <template v-slot:body="props">
      <q-tr :props="props">
        <q-td auto-width>
          <q-btn size="sm" round color="primary" glossy @click="props.expand = !props.expand" :icon="props.expand ? 'visibility_off' : 'visibility'"/>          
        </q-td>
        <q-td auto-width>
          <q-btn size="sm" round color="amber" glossy text-color="black" icon="school"  @click="prompt = true,  actual = String(props.row.nombre)"/>         
        </q-td>
        <q-td
          v-for="col in props.cols"
          :key="col.name"
          :props="props"
        >
         {{ col.value }} 
        </q-td>
      </q-tr>
      <q-tr v-show="props.expand" :props="props">
        <q-td colspan="100%">
          <div class="text-left">Localidad: {{ props.row.localidadNombre }}</div>
          <div class="text-left">Descripcion: {{ props.row.descripcion }}</div>
        </q-td>
      </q-tr>
    </template>
    </q-table>
  </div>            
</template>

<script>
import { ref, onMounted } from 'vue'
const columns = [
  { name: 'id', align: 'center', label: 'id', field: 'id', sortable: true },
  {
    name: 'nombre',
    required: true,
    label: 'Nombre de Curso',
    align: 'left',
   // field: 'nombre',
    field: row => row.nombre,
    format: val => `${val.toUpperCase()}`,
    sortable: true
  },
  { name: 'destinatarioNombre', align: 'center', label: 'Edades', field: 'destinatarioNombre', sortable: true },
  { name: 'fechaInicio', label: 'Inicio', field: 'fechaInicio', sortable: true },
  { name: 'fechaFin', label: 'Fin', field: 'fechaFin', sortable: true },
  { name: 'horario', label: 'Horario', field: 'horario', sortable: true },
  { name: 'cupos', label: 'Cupos', field: 'cupos', sortable: true },
  { name: 'descripcion', label: 'Descripcion', field: 'descripcion', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: 'localidadNombre', label: 'Localidad', field: 'localidadNombre', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) }
]

const originalRows = [
  { id: 1, nombre: 'hola', destinatarioNombre: 159, fechaInicio: 60, fechaFin: 24, horario: 40, cupos: 87, descripcion: '14%', localidadNombre: '1%' },
  { id: 2, nombre: 'Ice cream sandwich', destinatarioNombre: 237, fechaInicio: 9.0, fechaFin: 37, horario: 4.3, cupos: 129, descripcion: '8%', localidadNombre: '1%' },
  { id: 3, nombre: 'Eclair', destinatarioNombre: 262, fechaInicio: 16.0, fechaFin: 23, horario: 6.0, cupos: 337, descripcion: '6%', localidadNombre: '7%' },
  { id: 4, nombre: 'Cupcake', destinatarioNombre: 305, fechaInicio: 3.7, fechaFin: 67, horario: 4.3, cupos: 413, descripcion: '3%', localidadNombre: '8%' },
  { id: 5, nombre: 'Gingerbread', destinatarioNombre: 356, fechaInicio: 16.0, fechaFin: 49, horario: 3.9, cupos: 327, descripcion: '7%', localidadNombre: '16%' },
  { id: 6, nombre: 'Jelly bean', destinatarioNombre: 375, fechaInicio: 0.0, fechaFin: 94, horario: 0.0, cupos: 50, descripcion: '0%', localidadNombre: '0%' },
  { id: 7, nombre: 'Lollipop', destinatarioNombre: 392, fechaInicio: 0.2, fechaFin: 98, horario: 0, cupos: 38, descripcion: '0%', localidadNombre: '2%' },
  { id: 8, nombre: 'Honeycomb', destinatarioNombre: 408, fechaInicio: 3.2, fechaFin: 87, horario: 6.5, cupos: 562, descripcion: '0%', localidadNombre: '45%' },
  { id: 9, nombre: 'Donut', destinatarioNombre: 452, fechaInicio: 25.0, fechaFin: 51, horario: 4.9, cupos: 326, descripcion: '2%', localidadNombre: '22%' },
  { id: 10, nombre: 'KitKat', destinatarioNombre: 518, fechaInicio: 26.0, fechaFin: 65, horario: 7, cupos: 54, descripcion: '12%', localidadNombre: '6%' },
  { id: 11, nombre: 'Frozen Yogurt-1', destinatarioNombre: 159, fechaInicio: 6.0, fechaFin: 24, horario: 4.0, cupos: 87, descripcion: '14%', localidadNombre: '1%' },
  { id: 12, nombre: 'Ice cream sandwich-1', destinatarioNombre: 237, fechaInicio: 9.0, fechaFin: 37, horario: 4.3, cupos: 129, descripcion: '8%', localidadNombre: '1%' },
  { id: 13, nombre: 'Eclair-1', destinatarioNombre: 262, fechaInicio: 16.0, fechaFin: 23, horario: 6.0, cupos: 337, descripcion: '6%', localidadNombre: '7%' },
  { id: 14, nombre: 'Cupcake-1', destinatarioNombre: 305, fechaInicio: 3.7, fechaFin: 67, horario: 4.3, cupos: 413, descripcion: '3%', localidadNombre: '8%' },
  { id: 15, nombre: 'Gingerbread-1', destinatarioNombre: 356, fechaInicio: 16.0, fechaFin: 49, horario: 3.9, cupos: 327, descripcion: '7%', localidadNombre: '16%' },
  { id: 16, nombre: 'Jelly bean-1', destinatarioNombre: 375, fechaInicio: 0.0, fechaFin: 94, horario: 0.0, cupos: 50, descripcion: '0%', localidadNombre: '0%' },
  { id: 17, nombre: 'Lollipop-1', destinatarioNombre: 392, fechaInicio: 0.2, fechaFin: 98, horario: 0, cupos: 38, descripcion: '0%', localidadNombre: '2%' },
  { id: 18, nombre: 'Honeycomb-1', destinatarioNombre: 408, fechaInicio: 3.2, fechaFin: 87, horario: 6.5, cupos: 562, descripcion: '0%', localidadNombre: '45%' },
  { id: 19, nombre: 'Donut-1', destinatarioNombre: 452, fechaInicio: 25.0, fechaFin: 51, horario: 4.9, cupos: 326, descripcion: '2%', localidadNombre: '22%' },
  { id: 20, nombre: 'KitKat-1', destinatarioNombre: 518, fechaInicio: 26.0, fechaFin: 65, horario: 7, cupos: 54, descripcion: '12%', localidadNombre: '6%' },
  { id: 21, nombre: 'Frozen Yogurt-2', destinatarioNombre: 159, fechaInicio: 6.0, fechaFin: 24, horario: 4.0, cupos: 87, descripcion: '14%', localidadNombre: '1%' },
  { id: 22, nombre: 'Ice cream sandwich-2', destinatarioNombre: 237, fechaInicio: 9.0, fechaFin: 37, horario: 4.3, cupos: 129, descripcion: '8%', localidadNombre: '1%' },
  { id: 23, nombre: 'Eclair-2', destinatarioNombre: 262, fechaInicio: 16.0, fechaFin: 23, horario: 6.0, cupos: 337, descripcion: '6%', localidadNombre: '7%' },
  { id: 24, nombre: 'Cupcake-2', destinatarioNombre: 305, fechaInicio: 3.7, fechaFin: 67, horario: 4.3, cupos: 413, descripcion: '3%', localidadNombre: '8%' },
  { id: 25, nombre: 'Gingerbread-2', destinatarioNombre: 356, fechaInicio: 16.0, fechaFin: 49, horario: 3.9, cupos: 327, descripcion: '7%', localidadNombre: '16%' },
  { id: 26, nombre: 'Jelly bean-2', destinatarioNombre: 375, fechaInicio: 0.0, fechaFin: 94, horario: 0.0, cupos: 50, descripcion: '0%', localidadNombre: '0%' },
  { id: 27, nombre: 'Lollipop-2', destinatarioNombre: 392, fechaInicio: 0.2, fechaFin: 98, horario: 0, cupos: 38, descripcion: '0%', localidadNombre: '2%' },
  { id: 28, nombre: 'Honeycomb-2', destinatarioNombre: 408, fechaInicio: 3.2, fechaFin: 87, horario: 6.5, cupos: 562, descripcion: '0%', localidadNombre: '45%' },
  { id: 29, nombre: 'Donut-2', destinatarioNombre: 452, fechaInicio: 25.0, fechaFin: 51, horario: 4.9, cupos: 326, descripcion: '2%', localidadNombre: '22%' },
  { id: 30, nombre: 'KitKat-2', destinatarioNombre: 518, fechaInicio: 26.0, fechaFin: 65, horario: 7, cupos: 54, descripcion: '12%', localidadNombre: '6%' },
  { id: 31, nombre: 'Frozen Yogurt-3', destinatarioNombre: 159, fechaInicio: 6.0, fechaFin: 24, horario: 4.0, cupos: 87, descripcion: '14%', localidadNombre: '1%' },
  { id: 32, nombre: 'Ice cream sandwich-3', destinatarioNombre: 237, fechaInicio: 9.0, fechaFin: 37, horario: 4.3, cupos: 129, descripcion: '8%', localidadNombre: '1%' },
  { id: 33, nombre: 'Eclair-3', destinatarioNombre: 262, fechaInicio: 16.0, fechaFin: 23, horario: 6.0, cupos: 337, descripcion: '6%', localidadNombre: '7%' },
  { id: 34, nombre: 'Cupcake-3', destinatarioNombre: 305, fechaInicio: 3.7, fechaFin: 67, horario: 4.3, cupos: 413, descripcion: '3%', localidadNombre: '8%' },
  { id: 35, nombre: 'Gingerbread-3', destinatarioNombre: 356, fechaInicio: 16.0, fechaFin: 49, horario: 3.9, cupos: 327, descripcion: '7%', localidadNombre: '16%' },
  { id: 36, nombre: 'Jelly bean-3', destinatarioNombre: 375, fechaInicio: 0.0, fechaFin: 94, horario: 0.0, cupos: 50, descripcion: '0%', localidadNombre: '0%' },
  { id: 37, nombre: 'Lollipop-3', destinatarioNombre: 392, fechaInicio: 0.2, fechaFin: 98, horario: 0, cupos: 38, descripcion: '0%', localidadNombre: '2%' },
  { id: 38, nombre: 'Honeycomb-3', destinatarioNombre: 408, fechaInicio: 3.2, fechaFin: 87, horario: 6.5, cupos: 562, descripcion: '0%', localidadNombre: '45%' },
  { id: 39, nombre: 'Donut-3', destinatarioNombre: 452, fechaInicio: 25.0, fechaFin: 51, horario: 4.9, cupos: 326, descripcion: '2%', localidadNombre: '22%' },
  { id: 40, nombre: 'KitKat-3', destinatarioNombre: 518, fechaInicio: 26.0, fechaFin: 65, horario: 7, cupos: 54, descripcion: '12%', localidadNombre: '6%' }
]

export default {
  setup () {
    let actual = '0'
    let doc = ref()
    const rows = ref([])
    const filter = ref('')
    const loading = ref(false)
    const pagination = ref({
      sortBy: 'desc',
      descending: false,
      page: 1,
      rowsPerPage: 10,
      rowsNumber: 10,
    })
async function callEndpoints() {
    console.log(this.$routes)
}
    //router.push({name: 'Alumnos', params: {idCurso: actual, idAlumno: doc } })
    // emulate ajax call
    // SELECT * FROM ... WHERE...LIMIT...
    function fetchFromServer (startRow, count, filter, sortBy, descending) {
  

      const data = filter
      //  ? originalRows.filter(row => row.name.toUpperCase().includes(filter.toUpperCase()))
        ? originalRows.filter(row => (row.nombre.toUpperCase() + row.id).includes(filter.toUpperCase()))
        : originalRows.slice()

      // handle sortBy
      if (sortBy) {
        const sortFn = sortBy === 'desc'
          ? (descending
              ? (a, b) => (a.nombre > b.nombre ? -1 : a.nombre < b.nombre ? 1 : 0)
              : (a, b) => (a.nombre > b.nombre ? 1 : a.nombre < b.nombre ? -1 : 0)
            )
          : (descending
              ? (a, b) => (parseFloat(b[ sortBy ]) - parseFloat(a[ sortBy ]))
              : (a, b) => (parseFloat(a[ sortBy ]) - parseFloat(b[ sortBy ]))
            )
        data.sort(sortFn)
      }

      return data.slice(startRow, startRow + count)
    }

    // emulate 'SELECT count(*) FROM ...WHERE...'
    function getRowsNumberCount (filter) {
      if (!filter) {
        return originalRows.length
      }
      let count = 0
      originalRows.forEach(treat => {
        if (treat.nombre.includes(filter)){
          ++count
        }
        
      })
      return count
    }

    function onRequest (props) {
      const { page, rowsPerPage, sortBy, descending } = props.pagination
      const filter = props.filter

      loading.value = true

      // emulate server
      setTimeout(() => {
        // update rowsCount with appropriate value
        pagination.value.rowsNumber = getRowsNumberCount(filter)

        // get all rows if "All" (0) is selected
        const fetchCount = rowsPerPage === 0 ? pagination.value.rowsNumber : rowsPerPage

        // calculate starting row of data
        const startRow = (page - 1) * rowsPerPage

        // fetch data from "server"
        const returnedData = fetchFromServer(startRow, fetchCount, filter, sortBy, descending)

        // clear out existing data and add new
        rows.value.splice(0, rows.value.length, ...returnedData)

        // don't forget to update local pagination object
        pagination.value.page = page
        pagination.value.rowsPerPage = rowsPerPage
        pagination.value.sortBy = sortBy
        pagination.value.descending = descending

        // ...and turn of loading indicator
        loading.value = false
      }, 1500)
    }

    onMounted(() => {
      // get initial data from server (1st page)
      onRequest({
        pagination: pagination.value,
        filter: undefined
      })
    })

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
      visibleColumns: ref([  'nombre', 'destinatarioNombre', 'fechaInicio', 'fechaFin', 'horario' ]),
      onRequest,
      prompt: ref(false),
      callEndpoints,
    }
  }
}
</script>
