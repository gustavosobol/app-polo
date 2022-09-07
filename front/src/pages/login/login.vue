<template>
  <div class="q-pa-md">
    <div class="q-gutter-y-md" style="max-width: 100%; max-height: 100px">
      <q-card>
        <q-tabs
          v-model="tab"
          dense
          class="text-grey"
          active-color="primary"
          indicator-color="primary"
          align="justify"
          narrow-indicator
        >
          <q-tab name="login" label="Login" />
          <!-- <q-tab name="addUser" label="Nuevo Usuario" /> -->
        </q-tabs>

        <q-separator />

        <q-tab-panels v-model="tab" animated align="center">
          <q-tab-panel name="login">
            <div
              class="full-width row wrap justify-center items-start content-start"
            >
              <div class="column q-pa-lg">
                <!-- v-if="register === false" -->

                <q-card
                  square
                  class="shadow-24"
                  style="width: 300px; height: 525px"
                >
                  <q-card-section class="bg-deep-purple-7">
                    <h4 class="text-h5 text-white q-my-md">
                      Restaurant Delilah
                    </h4>
                  </q-card-section>
                  <q-card-section>
                    <q-form class="q-px-sm q-pt-xl">
                      <q-input
                        square
                        clearable
                        v-model="email"
                        type="email"
                        label="Email"
                      >
                        <!--          :rules="[
                  (val) =>
                    /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(val) ||
                    'Debe ingresar un mail valido',
                ]" -->
                        <template v-slot:prepend>
                          <q-icon name="email" />
                        </template>
                      </q-input>
                      <q-input
                        square
                        clearable
                        v-model="password"
                        type="password"
                        label="Contraseña"
                        :rules="[
                          (val) =>
                            (val && val.length > 0) ||
                            'Debe ingresar al menos un caracter',
                        ]"
                      >
                        <template v-slot:prepend>
                          <q-icon name="lock" />
                        </template>
                      </q-input>
                    </q-form>
                  </q-card-section>
                  <q-card-section>
                    <div class="text-center q-pa-md q-gutter-md">
                      <!-- <q-btn round color="indigo-7">
                        <q-icon name="fab fa-facebook-f" size="1.2rem" />
                      </q-btn> -->
                      <q-btn round color="red-8">
                        <q-icon
                          name="img:/icons/google.png"
                          size="40px"
                          @click="google"
                        />
                      </q-btn>
                      <q-btn round color="light-blue-5">
                        <q-icon
                          name="img:/icons/linkedin.png"
                          size="40px"
                          @click="linkedin"
                        />
                      </q-btn>
                    </div>
                  </q-card-section>
                  <q-card-actions class="q-px-lg">
                    <q-btn
                      unelevated
                      size="lg"
                      color="purple-4"
                      class="full-width text-white"
                      label="Ingresar"
                      @click="login"
                    />
                  </q-card-actions>
                  <!--   <q-card-section class="text-center q-pa-sm">
                    <p class="text-grey-6">Olvidaste tu contraseña?</p>
                  </q-card-section> -->
                </q-card>
              </div>
            </div>
          </q-tab-panel>

          <!--        <q-tab-panel name="addUser">
            <AddUser :register="register" />
          </q-tab-panel> -->
        </q-tab-panels>
      </q-card>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import { api } from "boot/axios";
import { useQuasar, SessionStorage } from "quasar";
/* import AddUser from "../../components/user/AddUser.vue";
 */ import { useRouter } from "vue-router";

export default {
  name: "Login",
  setup() {
    const router = useRouter();
    const $q = useQuasar();
    const register = ref(false);
    const email = ref(null);
    const username = ref(null);
    const password = ref(null);
    const datos = ref(null);
    return {
      async login() {
        const user = { usuario: email.value, contrasena: password.value };
        await api
          .post("/login", user, {
            headers: {
              accept: "application/json",
            },
          })
          .then((response) => {
            SessionStorage.set("jwt", response.data.message);
            return router.push({ name: "home" });
          })
          .catch((error) => {
            $q.notify({
              color: "negative",
              position: "bottom",
              message: "Usuario o contraseña incorrecto",
              icon: "sentiment_very_dissatisfied",
            });
          });
      },
      async google() {
        SessionStorage.remove("jwt");
        location.href = `${process.env.API}/google`;
      },
      async linkedin() {
        SessionStorage.remove("jwt");
        location.href = `${process.env.API}/linkedin`;
      },
      datos,
      register,
      email,
      username,
      password,
      tab: ref("login"),
      splitterModel: ref(20),
    };
  },
  /*   components: { AddUser },
   */
};
</script>
