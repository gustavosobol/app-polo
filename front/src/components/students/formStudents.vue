<template>
  <q-form @reset="onReset" class="q-gutter-md">
    <!--     <div class="row sm-gutter">
      <div class="col-12 col-sm-6 q-gutter-sm q-col-gutter-sm"> -->
    <!-- Columna1 -->
    <!--Documento-->
    <q-input
      filled
      type="number"
      v-model="nro_doc"
      label="Nro Documento"
      lazy-rules
      @blur="returnAlumno"
      :rules="[
        (val) =>
          (val !== null && val !== '') || 'Ingrese su número de documento',
        (val) => val.length >= 7 || 'El numero debe ser valido',
      ]"
      @keyup="setData"
    />
    <!-- Apellido -->
    <q-input
      filled
      v-model="apellido"
      label="Apellido"
      hint=""
      lazy-rules
      :rules="[(val) => (val && val.length > 0) || 'Debe ingresar su apellido']"
      @keyup="setData"
    />
    <!-- Nombre -->
    <q-input
      filled
      v-model="nombre"
      label="Nombre"
      hint=""
      lazy-rules
      :rules="[
        (val) => (val && val.length > 0) || 'Debe ingresar su nombre',
        (val) => (val && val.length < 30) || 'Demasiado largo',
      ]"
      @keyup="setData"
    />
    <!-- Fecha Nacimiento -->
    <q-input filled v-model="date" label="Fecha Nacimiento" hint="">
      <template v-slot:append>
        <q-icon name="event" class="cursor-pointer">
          <q-popup-proxy
            ref="qDateProxy"
            cover
            transition-show="scale"
            transition-hide="scale"
          >
            <!-- mask="MM-DD-YYYY" -->
            <q-date v-model="date">
              <div class="row items-center justify-end">
                <q-btn v-close-popup label="Close" color="primary" flat />
              </div>
            </q-date>
          </q-popup-proxy>
        </q-icon>
      </template>
    </q-input>
    <!--     </div> -->

    <!--  <div class="col-12 col-sm-6 q-gutter-sm q-col-gutter-sm"> -->
    <!-- Columna2 -->
    <!-- email -->
    <q-input
      filled
      v-model="email"
      type="email"
      label="Mail"
      hint=""
      lazy-rules
      :rules="[
        (val) =>
          /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(val) ||
          'Debe ingresar un mail valido',
      ]"
      @keyup="setData"
    />
    <!-- celular -->
    <q-input
      filled
      v-model="celular"
      type="number"
      label="Celular"
      hint=""
      lazy-rules
      :rules="[
        (val) => (val && val.length > 0) || 'Debe ingresar un nro de celular',
      ]"
      @keyup="setData"
    />
    <!-- domicilio -->
    <q-input
      filled
      v-model="domicilio"
      label="Domicilio"
      hint=""
      lazy-rules
      :rules="[
        (val) => (val && val.length > 0) || 'Debe ingresar un domicilio',
      ]"
      @keyup="setData"
    />
    <!-- barrio -->
    <q-select
      filled
      v-model="barrio"
      :options="listaBarrios"
      label="Barrio"
      :rules="[(val) => val !== null || 'Debe seleccionar un barrio']"
    />
    <!-- Localidad -->
    <q-select
      filled
      v-model="localidadId"
      :options="listaLocalidades"
      option-value="id"
      option-label="nombre"
      label="Localidad"
      :rules="[(val) => val !== null || 'Debe seleccionar una localidad']"
    />
    <q-toggle v-model="accept" label="Acepta la reserva" />

    <div>
      <q-btn
        label="Guardar"
        type="submit"
        color="primary"
        style="max-width: 1000px"
        @click="showCustom"
      />
      <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm" />
    </div>

    <!--   CONFIRM DIALOG -->
  </q-form>
</template>

<script>
import { api } from "boot/axios";
import { defineComponent, ref, onMounted } from "vue";
import { useQuasar, QSpinnerGears } from "quasar";
import { useRoute, useRouter } from "vue-router";

export default defineComponent({
  setup() {
    const $q = useQuasar();
    const route = useRoute();
    const router = useRouter();
    //Parametros Recibidos
    const idCurso = route.params.idCurso;
    const nombreCurso = route.params.nombreCurso;
    //FORMULARIOS
    const nro_doc = ref(route.params.idAlumno);
    const apellido = ref(null);
    const nombre = ref(null);
    const email = ref(null);
    const celular = ref(null);
    const domicilio = ref(null);
    const barrio = ref(null);
    const localidadId = ref(null);
    const accept = ref(false);
    const newStudents = ref(false);

    function showCustom() {
      // we simulate some progress here...
      let percentage = 0;

      if (accept.value !== true) {
        $q.notify({
          color: "red-5",
          textColor: "white",
          icon: "warning",
          message: "Debe aceptar la reserva ",
        });
      } else {
        let titulo = "Genial!!!!";
        let mensaje = `Se realizo la reserva en el curso ${nombreCurso} para el alumno ${apellido.value}, ${nombre.value}`;
        const dialog = $q.dialog({
          title: "Guardando...",
          dark: false,
          message: "0%",
          progress: {
            spinner: QSpinnerGears,
            color: "blue-9",
          },
          persistent: true, // we want the user to not be able to close it
          ok: false, // we want the user to not be able to close it
        });

        const alumnoNew = {
          nroDocumento: nro_doc.value,
          apellido: apellido.value,
          nombre: nombre.value,
          fechaNacimiento: date.value,
          email: email.value,
          celular: celular.value,
          domicilio: domicilio.value,
          barrio: barrio.value,
          localidadId: localidadId.value.id,
        };

        if (newStudents.value === false) {
          api
            .post("Alumno", alumnoNew, {
              headers: {
                accept: "application/json",
              },
            })
            .then((response) => {})
            .catch((error) => {
              percentage = 100;
              titulo = "Ohhhh Ocurrio un error!";
              mensaje = `Error: ${error}`;
            });
        } else {
          api
            .patch(`Alumno?nroDocumento=eq.${nro_doc.value}`, alumnoNew, {
              headers: {
                accept: "application/json",
              },
            })
            .then((response) => {})
            .catch((error) => {
              percentage = 100;
              titulo = "Ohhhh Ocurrio un error!";
              mensaje = `Error: ${error}`;
            });
        }

        // Busco id del alumno
        let idAlumn = 0;
        api
          .get(
            `Alumno?select=*, Localidad(nombre)&nroDocumento=eq.${nro_doc.value}`,
            {
              headers: {
                accept: "application/json",
              },
            }
          )
          .then((response) => {
            data.value = response.data;
            if (response.data.length > 0) {
              // agrego la solicitud del alumno al curso
              const alumnoCursoNew = {
                cursoActivoId: idCurso,
                alumnoId: data.value[0].id,
                //   descripcion: nombre.value,
                nombreMostrar: `${nombreCurso} - ${apellido.value}, ${nombre.value}`,
              };
              api
                .post("AlumnoOnCursoActivo", alumnoCursoNew, {
                  headers: {
                    accept: "application/json",
                  },
                })
                .then((response) => {
                  percentage = 100;
                  /* console.log(`se guardo correctamente el AlumnoOnCursoActivo`);
                  $q.notify({
                    color: "green-4",
                    textColor: "white",
                    icon: "cloud_done",
                    message: "Submitted",
                  }); */
                })
                .catch((error) => {
                  percentage = 100;
                  if (error.response.status === 409) {
                    titulo = "Ohhhh Ocurrio un error!";
                    mensaje = "El alumno ya se encuentra en el curso cargado";
                  } else if (error.response.status === 400) {
                    titulo = "Ohhhh Ocurrio un error!";
                    mensaje = "Es el error 400";
                  } else {
                    $q.notify({
                      color: "negative",
                      position: "bottom",
                      message: "No se pudo guardar el nuevo usuario",
                      icon: "sentiment_very_dissatisfied",
                    });
                  }
                });
            }
          })
          .catch((error) => {
            percentage = 100;
            titulo = "Ohhhh Ocurrio un error!";
            mensaje = `Error: ${error}`;
          });

        const interval = setInterval(() => {
          percentage = Math.min(
            100,
            percentage + Math.floor(Math.random() * 22)
          );
          // we update the dialog
          dialog.update({
            message: `${percentage}%`,
          });

          // if we are done...
          if (percentage === 100) {
            clearInterval(interval);

            dialog.update({
              title: titulo,
              message: mensaje,
              progress: false,
              ok: true,
            });
          }
        }, 200);
        router.push({ name: "Cursos" });
      }
    }

    //CALENDARIO
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, "0");
    var mm = String(today.getMonth() + 1).padStart(2, "0"); //January is 0!
    var yyyy = today.getFullYear();

    today = yyyy + "-" + mm + "-" + dd;
    const date = ref(null);
    const data = ref([]);
    /* localidades */
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
    /* Busca alumno */
    function returnAlumno() {
      if (nro_doc.value !== undefined) {
        api
          .get(
            `Alumno?select=*, Localidad(nombre)&nroDocumento=eq.${nro_doc.value}`,
            {
              headers: {
                accept: "application/json",
              },
            }
          )
          .then((response) => {
            data.value = response.data;
            if (response.data.length > 0) {
              apellido.value = data.value[0].apellido;
              nombre.value = data.value[0].nombre;
              date.value = data.value[0].fechaNacimiento;
              email.value = data.value[0].email;
              celular.value = data.value[0].celular;
              domicilio.value = data.value[0].domicilio;
              barrio.value = data.value[0].barrio;
              localidadId.value = data.value[0].Localidad.nombre;
              newStudents.value = true;
            }
          })
          .catch((error) => {
            $q.notify({
              color: "negative",
              position: "bottom",
              message: ` Mensaje ${error}`,
              icon: "report_problem",
            });
          });
      }
    }

    onMounted(() => {
      returnLocalidades();
      returnAlumno();
    });

    return {
      /*   onSubmit() {
        //confirm = true;
        if (accept.value !== true) {
          $q.notify({
            color: "red-5",
            textColor: "white",
            icon: "warning",
            message: "Debe aceptar la reserva ",
          });
        } else {
          const alumnoNew = {
            nroDocumento: nro_doc.value,
            apellido: apellido.value,
            nombre: nombre.value,
            fechaNacimiento: date.value,
            email: email.value,
            celular: celular.value,
            domicilio: domicilio.value,
            barrio: barrio.value,
            localidadId: localidadId.value.id,
          };

          if (newStudents.value === false) {
            api
              .post("Alumno", alumnoNew, {
                headers: {
                  accept: "application/json",
                },
              })
              .then((response) => {
                console.log(`se guardo correctamente el alumno`);
              })
              .catch((error) => {
                $q.notify({
                  color: "negative",
                  position: "bottom",
                  message: "No se pudo guardar el nuevo usuario",
                  icon: "sentiment_very_dissatisfied",
                });
              });
          } else {
            api
              .patch(`Alumno?nroDocumento=eq.${nro_doc.value}`, alumnoNew, {
                headers: {
                  accept: "application/json",
                },
              })
              .then((response) => {
                $q.notify({
                  color: "positive",
                  position: "bottom",
                  message: `Se actualizaron los datos del alumnos ${alumnoNew.apellido}, ${alumnoNew.nombre} correctamente`,
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
          }

          // Busco id del alumno
          let idAlumn = 0;
          api
            .get(
              `Alumno?select=*, Localidad(nombre)&nroDocumento=eq.${nro_doc.value}`,
              {
                headers: {
                  accept: "application/json",
                },
              }
            )
            .then((response) => {
              data.value = response.data;
              if (response.data.length > 0) {
             // agrego la solicitud del alumno al curso
                const alumnoCursoNew = {
                  cursoActivoId: idCurso,
                  alumnoId: data.value[0].id,
                  //   descripcion: nombre.value,
                  nombreMostrar: `${nombreCurso} - ${apellido.value}, ${nombre.value}`,
                };
                api
                  .post("AlumnoOnCursoActivo", alumnoCursoNew, {
                    headers: {
                      accept: "application/json",
                    },
                  })
                  .then((response) => {
                    console.log(
                      `se guardo correctamente el AlumnoOnCursoActivo`
                    );
                    $q.notify({
                      color: "green-4",
                      textColor: "white",
                      icon: "cloud_done",
                      message: "Submitted",
                    });
                  })
                  .catch((error) => {
                    console.log(`error personal ${error}`);
                    $q.notify({
                      color: "negative",
                      position: "bottom",
                      message: "No se pudo guardar el nuevo usuario",
                      icon: "sentiment_very_dissatisfied",
                    });
                  });
              }
            })
            .catch((error) => {
              $q.notify({
                color: "negative",
                position: "bottom",
                message: ` Mensaje ${error}`,
                icon: "report_problem",
              });
            });
        }
      }, */
      //FORMULARIOS
      nro_doc,
      apellido,
      nombre,
      date,
      email,
      celular,
      domicilio,
      localidadId,
      barrio,
      listaBarrios: ["Chacra", "Mutual", "Austral"],
      listaLocalidades: localidades,
      //CALENDARIO
      // splitterModel: ref(50),
      accept,
      //return funciones
      returnAlumno,
      showCustom,
      onReset() {
        nro_doc.value = null;
        apellido.value = null;
        nombre.value = null;
        date.value = today;
        email.value = null;
        celular.value = null;
        domicilio.value = null;
        barrio.value = null;
        accept.value = false;
      },
    };
  },
  methods: {
    setData() {
      this.$emit("getData", {
        nombre: this.nombre,
        apellido: this.apellido,
        fecha_nacimiento: this.date,
        email: this.email,
        celular: this.celular,
        domicilio: this.domicilio,
        barrio: this.barrio,
      });
    },
  },
});
</script>
