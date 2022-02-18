# app-polo

## Necesidades del polo

- **Identificar a las personas datos filiatorios** (dni, apellido y nombre, domicilio, barrio, localidad, fecha nacimiento)
- Pendiente **Medio de contactos** (mail, celular, whatsapp, telegram, redes sociales que usa)
- Pendiente **Edad** el sistema debe realizar el calculo de la edad a la fecha de inicio o fin del curso
- Pendiente **Nivel de estudio** registrar el nivel de estudio del alumno y si asiste a una escuela el registro de la misma
- Pendiente **Contacto de urgencia** registrar el nombre y un contacto por cualquier urgencia
- Pendiente a futuro **intereses de cursos de las personas** Ver la forma de realizar un registro de intereses
- **registro de cursos realizados** registrar todos los cursos que realizan los alumnos en los polos
- Pendiente **registro de asistencia a los cursos**
- Pendiente **registros de profesores** con todos los datos filiatorios
- Pendiente **registro de instituciones** (todos los polos con sus medios de contados)
- **registros de cursos/actividades** (talleres charlas etc) que se realizan en el polo
- **que los cursos se registre fecha desde hasta - horarios - dias - profesor que dicta capacidades de alumnos en los cursos**
- **cantidad de aulas en cada institucion**
- Pendiente a futuro **Encuestas para los alumnos**

### Pre-requisitos 📋

**Tener instalado docker y docker-compose**

### Instalación 🔧

**Paso 1:** descargar el repositorio

```
git clone
```

**Paso 2:** ingresar a la carpeta decargada

**Paso 3:** Ejecutar el comando, este comando lo hace descarga e instala todas las dependencias que necesita el proyecto para poder ejecutarse

```
docker-compose run app npm install
```

**Paso 4:** Ejecuta el servidor para su conexion

Primera vez ejecuta docker-compose up

Si no presenta ningun error accede a la pagina y prueba que el proyecto este funcionando correctamente

Si emite un error para la ejecución con Ctrl + c y ejecuta el comando

docker-compose run app quasar upgrade --install
el comando anterior lo que hace es actualizar el nucleo de quasar

vuelve a ejecutar el comando docker-compose up
y verifica si se ejecuto correctamente

si todo funciono bien puedes parar la ejecucion con Ctrl + c y ejecuta el comando

```
docker-compose up -d
```

para que quede funcionando de manera permanente

15/02/2022 Necesidades nuevas
Agregar en alumnos campo observaciones
Nombre de tallerrista
