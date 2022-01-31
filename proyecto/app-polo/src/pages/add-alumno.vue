<template>
  <q-page class="flex flex-">
    <q-form action="https://www.google.com" method="post" @submit.prevent="onSubmit">
      <q-input name="firstname" v-model="firstname">
      </q-input>

        <div class="q-pa-md">
          <q-date
            v-model="date"
            :events="events"
            event-color="orange"
          />
        </div>
    </q-form>
  </q-page>
</template>

<script>
import { defineComponent, ref } from 'vue';

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
      date: ref('2019/02/01'),
      events: [ '2019/02/01', '2019/02/05', '2019/02/06' ]
    }
  }
})

</script>
