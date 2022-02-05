<template>
  <q-page class="flex flex-">
    <q-form action="https://www.google.com" method="post" @submit.prevent="onSubmit">
      <q-input name="firstname" v-model="firstname">
      </q-input>





<div>User {{ $route.params.idAlumno }} - Curso {{ $route.params.idCurso }}</div>





<div class="q-pa-md" style="max-width: 300px">
    <q-input filled v-model="date" mask="date" :rules="['date']">
      <template v-slot:append>
        <q-icon name="event" class="cursor-pointer">
          <q-popup-proxy ref="qDateProxy" cover transition-show="scale" transition-hide="scale">
            <q-date v-model="date">
              <div class="row items-center justify-end">
                <q-btn v-close-popup label="Close" color="primary" flat />
              </div>
            </q-date>
          </q-popup-proxy>
        </q-icon>
      </template>
    </q-input>
  </div>
    </q-form>
  </q-page>
</template>

<script>
import { defineComponent, ref } from 'vue';

var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
var yyyy = today.getFullYear();

today = yyyy+ '/' + mm + '/' + dd  ;
export default defineComponent({
  name: 'PageIndex',
  data() {
    return {
      firstname: null
    }
  },
  methods: {
    
    onSubmit (evt) {
      console.log('@submit - do something here', evt)
      evt.target.submit()
    }
  },
  
  setup () {
    return {
      splitterModel: ref(50),
      date: ref(today)
    }
  }
})

</script>
