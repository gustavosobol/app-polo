<template>
  <div class="q-pa-md">
    <q-table
      title="Treats"
      :rows="rows"
      :columns="columns"
      row-key="id"
      :loading="loading"
      :filter="filter"
      @request="onRequest"
      binary-state-sort
    >
      <template v-slot:top-right>
        <q-input borderless dense debounce="300" v-model="filter" placeholder="Search">
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
      </template>
      
   <template v-slot:header="props">
        <q-tr :props="props">
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
            <q-btn size="sm" color="accent" round dense @click="props.expand = !props.expand" :icon="props.expand ? 'warning' : 'add'" />
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
            <div class="text-left">This is expand slot for row above: {{ props.row.name }}.</div>
          </q-td>
        </q-tr>
      </template>
    </q-table>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'

const columns = [
  {
    name: 'nombre',
    required: true,
    label: 'Nombre de Curso',
    align: 'left',
    field: 'nombre',
  //  field: row => row.nombre,
    format: val => `${val.toUpperCase()}`,
    sortable: true
  },
  { name: 'id', align: 'center', label: 'id', field: 'id', sortable: true },
  { name: 'destinatario', align: 'center', label: 'Edades', field: 'destinatarioNombre', sortable: true },
  { name: 'fat', label: 'Fat (g)', field: 'fat', sortable: true },
  { name: 'carbs', label: 'Carbs (g)', field: 'carbs', sortable: true },
  { name: 'protein', label: 'Protein (g)', field: 'protein', sortable: true },
  { name: 'sodium', label: 'Sodium (mg)', field: 'sodium', sortable: true },
  { name: 'calcium', label: 'Calcium (%)', field: 'calcium', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: 'iron', label: 'Iron (%)', field: 'iron', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) }
]

const originalRows = [
  { id: 'N1', nombre: 'Frozen Yogurt', destinatarioNombre: 159, fat: 6.0, carbs: 24, protein: 4.0, sodium: 87, calcium: '14%', iron: '1%' },
  { id: 2, nombre: 'Ice cream sandwich', destinatarioNombre: 237, fat: 9.0, carbs: 37, protein: 4.3, sodium: 129, calcium: '8%', iron: '1%' },
  { id: 3, nombre: 'Eclair', destinatarioNombre: 262, fat: 16.0, carbs: 23, protein: 6.0, sodium: 337, calcium: '6%', iron: '7%' },
  { id: 4, nombre: 'Cupcake', destinatarioNombre: 305, fat: 3.7, carbs: 67, protein: 4.3, sodium: 413, calcium: '3%', iron: '8%' },
  { id: 5, nombre: 'Gingerbread', destinatarioNombre: 356, fat: 16.0, carbs: 49, protein: 3.9, sodium: 327, calcium: '7%', iron: '16%' },
  { id: 6, nombre: 'Jelly bean', destinatarioNombre: 375, fat: 0.0, carbs: 94, protein: 0.0, sodium: 50, calcium: '0%', iron: '0%' },
  { id: 7, nombre: 'Lollipop', destinatarioNombre: 392, fat: 0.2, carbs: 98, protein: 0, sodium: 38, calcium: '0%', iron: '2%' },
  { id: 8, nombre: 'Honeycomb', destinatarioNombre: 408, fat: 3.2, carbs: 87, protein: 6.5, sodium: 562, calcium: '0%', iron: '45%' },
  { id: 9, nombre: 'Donut', destinatarioNombre: 452, fat: 25.0, carbs: 51, protein: 4.9, sodium: 326, calcium: '2%', iron: '22%' },
  { id: 10, nombre: 'KitKat', destinatarioNombre: 518, fat: 26.0, carbs: 65, protein: 7, sodium: 54, calcium: '12%', iron: '6%' },
  { id: 11, nombre: 'Frozen Yogurt-1', destinatarioNombre: 159, fat: 6.0, carbs: 24, protein: 4.0, sodium: 87, calcium: '14%', iron: '1%' },
  { id: 12, nombre: 'Ice cream sandwich-1', destinatarioNombre: 237, fat: 9.0, carbs: 37, protein: 4.3, sodium: 129, calcium: '8%', iron: '1%' },
  { id: 13, nombre: 'Eclair-1', destinatarioNombre: 262, fat: 16.0, carbs: 23, protein: 6.0, sodium: 337, calcium: '6%', iron: '7%' },
  { id: 14, nombre: 'Cupcake-1', destinatarioNombre: 305, fat: 3.7, carbs: 67, protein: 4.3, sodium: 413, calcium: '3%', iron: '8%' },
  { id: 15, nombre: 'Gingerbread-1', destinatarioNombre: 356, fat: 16.0, carbs: 49, protein: 3.9, sodium: 327, calcium: '7%', iron: '16%' },
  { id: 16, nombre: 'Jelly bean-1', destinatarioNombre: 375, fat: 0.0, carbs: 94, protein: 0.0, sodium: 50, calcium: '0%', iron: '0%' },
  { id: 17, nombre: 'Lollipop-1', destinatarioNombre: 392, fat: 0.2, carbs: 98, protein: 0, sodium: 38, calcium: '0%', iron: '2%' },
  { id: 18, nombre: 'Honeycomb-1', destinatarioNombre: 408, fat: 3.2, carbs: 87, protein: 6.5, sodium: 562, calcium: '0%', iron: '45%' },
  { id: 19, nombre: 'Donut-1', destinatarioNombre: 452, fat: 25.0, carbs: 51, protein: 4.9, sodium: 326, calcium: '2%', iron: '22%' },
  { id: 20, nombre: 'KitKat-1', destinatarioNombre: 518, fat: 26.0, carbs: 65, protein: 7, sodium: 54, calcium: '12%', iron: '6%' },
  { id: 21, nombre: 'Frozen Yogurt-2', destinatarioNombre: 159, fat: 6.0, carbs: 24, protein: 4.0, sodium: 87, calcium: '14%', iron: '1%' },
  { id: 22, nombre: 'Ice cream sandwich-2', destinatarioNombre: 237, fat: 9.0, carbs: 37, protein: 4.3, sodium: 129, calcium: '8%', iron: '1%' },
  { id: 23, nombre: 'Eclair-2', destinatarioNombre: 262, fat: 16.0, carbs: 23, protein: 6.0, sodium: 337, calcium: '6%', iron: '7%' },
  { id: 24, nombre: 'Cupcake-2', destinatarioNombre: 305, fat: 3.7, carbs: 67, protein: 4.3, sodium: 413, calcium: '3%', iron: '8%' },
  { id: 25, nombre: 'Gingerbread-2', destinatarioNombre: 356, fat: 16.0, carbs: 49, protein: 3.9, sodium: 327, calcium: '7%', iron: '16%' },
  { id: 26, nombre: 'Jelly bean-2', destinatarioNombre: 375, fat: 0.0, carbs: 94, protein: 0.0, sodium: 50, calcium: '0%', iron: '0%' },
  { id: 27, nombre: 'Lollipop-2', destinatarioNombre: 392, fat: 0.2, carbs: 98, protein: 0, sodium: 38, calcium: '0%', iron: '2%' },
  { id: 28, nombre: 'Honeycomb-2', destinatarioNombre: 408, fat: 3.2, carbs: 87, protein: 6.5, sodium: 562, calcium: '0%', iron: '45%' },
  { id: 29, nombre: 'Donut-2', destinatarioNombre: 452, fat: 25.0, carbs: 51, protein: 4.9, sodium: 326, calcium: '2%', iron: '22%' },
  { id: 30, nombre: 'KitKat-2', destinatarioNombre: 518, fat: 26.0, carbs: 65, protein: 7, sodium: 54, calcium: '12%', iron: '6%' },
  { id: 31, nombre: 'Frozen Yogurt-3', destinatarioNombre: 159, fat: 6.0, carbs: 24, protein: 4.0, sodium: 87, calcium: '14%', iron: '1%' },
  { id: 32, nombre: 'Ice cream sandwich-3', destinatarioNombre: 237, fat: 9.0, carbs: 37, protein: 4.3, sodium: 129, calcium: '8%', iron: '1%' },
  { id: 33, nombre: 'Eclair-3', destinatarioNombre: 262, fat: 16.0, carbs: 23, protein: 6.0, sodium: 337, calcium: '6%', iron: '7%' },
  { id: 34, nombre: 'Cupcake-3', destinatarioNombre: 305, fat: 3.7, carbs: 67, protein: 4.3, sodium: 413, calcium: '3%', iron: '8%' },
  { id: 35, nombre: 'Gingerbread-3', destinatarioNombre: 356, fat: 16.0, carbs: 49, protein: 3.9, sodium: 327, calcium: '7%', iron: '16%' },
  { id: 36, nombre: 'Jelly bean-3', destinatarioNombre: 375, fat: 0.0, carbs: 94, protein: 0.0, sodium: 50, calcium: '0%', iron: '0%' },
  { id: 37, nombre: 'Lollipop-3', destinatarioNombre: 392, fat: 0.2, carbs: 98, protein: 0, sodium: 38, calcium: '0%', iron: '2%' },
  { id: 38, nombre: 'Honeycomb-3', destinatarioNombre: 408, fat: 3.2, carbs: 87, protein: 6.5, sodium: 562, calcium: '0%', iron: '45%' },
  { id: 39, nombre: 'Donut-3', destinatarioNombre: 452, fat: 25.0, carbs: 51, protein: 4.9, sodium: 326, calcium: '2%', iron: '22%' },
  { id: 40, nombre: 'KitKat-3', destinatarioNombre: 518, fat: 26.0, carbs: 65, protein: 7, sodium: 54, calcium: '12%', iron: '6%' }
]

export default {
  setup () {
    const rows = ref([])
    const filter = ref('')
    const loading = ref(false)
    const pagination = ref({
      sortBy: 'desc',
      descending: false,
      page: 1,
      rowsPerPage: 10,
      rowsNumber: 10
    })

    // emulate ajax call
    // SELECT * FROM ... WHERE...LIMIT...
    function fetchFromServer (startRow, count, filter, sortBy, descending) {
      const data = filter
        //? originalRows.filter(row => row.name.toUpperCase().includes(filter.toUpperCase()))
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
      filter,
      loading,
      pagination,
      columns,
      rows,

      onRequest
    }
  }
}
</script>
