-- DropForeignKey
ALTER TABLE "Alumno" DROP CONSTRAINT "Alumno_localidadId_fkey";

-- DropForeignKey
ALTER TABLE "AlumnoOnCursoActivo" DROP CONSTRAINT "AlumnoOnCursoActivo_alumnoId_fkey";

-- DropForeignKey
ALTER TABLE "AlumnoOnCursoActivo" DROP CONSTRAINT "AlumnoOnCursoActivo_cursoActivoId_fkey";

-- DropForeignKey
ALTER TABLE "Curso" DROP CONSTRAINT "Curso_personalId_fkey";

-- DropForeignKey
ALTER TABLE "Curso" DROP CONSTRAINT "Curso_tipoCursoId_fkey";

-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_localidadId_cursoId_fkey";

-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_salaId_fkey";

-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_turnoId_fkey";

-- DropForeignKey
ALTER TABLE "DestinatarioOnCurso" DROP CONSTRAINT "DestinatarioOnCurso_cursoId_fkey";

-- DropForeignKey
ALTER TABLE "DestinatarioOnCurso" DROP CONSTRAINT "DestinatarioOnCurso_destinatarioId_fkey";

-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_cursoId_fkey";

-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_localidadId_fkey";

-- DropForeignKey
ALTER TABLE "Personal" DROP CONSTRAINT "Personal_localidadId_fkey";

-- DropForeignKey
ALTER TABLE "Salas" DROP CONSTRAINT "Salas_localidadId_fkey";

-- AddForeignKey
ALTER TABLE "Curso" ADD CONSTRAINT "Curso_tipoCursoId_fkey" FOREIGN KEY ("tipoCursoId") REFERENCES "TipoCurso"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Curso" ADD CONSTRAINT "Curso_personalId_fkey" FOREIGN KEY ("personalId") REFERENCES "Personal"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD CONSTRAINT "LocalidadOnCurso_localidadId_fkey" FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD CONSTRAINT "LocalidadOnCurso_cursoId_fkey" FOREIGN KEY ("cursoId") REFERENCES "Curso"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DestinatarioOnCurso" ADD CONSTRAINT "DestinatarioOnCurso_cursoId_fkey" FOREIGN KEY ("cursoId") REFERENCES "Curso"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DestinatarioOnCurso" ADD CONSTRAINT "DestinatarioOnCurso_destinatarioId_fkey" FOREIGN KEY ("destinatarioId") REFERENCES "Destinatarios"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AlumnoOnCursoActivo" ADD CONSTRAINT "AlumnoOnCursoActivo_alumnoId_fkey" FOREIGN KEY ("alumnoId") REFERENCES "Alumno"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AlumnoOnCursoActivo" ADD CONSTRAINT "AlumnoOnCursoActivo_cursoActivoId_fkey" FOREIGN KEY ("cursoActivoId") REFERENCES "CursosActivos"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Alumno" ADD CONSTRAINT "Alumno_localidadId_fkey" FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Personal" ADD CONSTRAINT "Personal_localidadId_fkey" FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Salas" ADD CONSTRAINT "Salas_localidadId_fkey" FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD CONSTRAINT "CursosActivos_turnoId_fkey" FOREIGN KEY ("turnoId") REFERENCES "Turno"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD CONSTRAINT "CursosActivos_localidadId_cursoId_fkey" FOREIGN KEY ("localidadId", "cursoId") REFERENCES "LocalidadOnCurso"("localidadId", "cursoId") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD CONSTRAINT "CursosActivos_salaId_fkey" FOREIGN KEY ("salaId") REFERENCES "Salas"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- RenameIndex
ALTER INDEX "Alumno.nroDocumento_unique" RENAME TO "Alumno_nroDocumento_key";

-- RenameIndex
ALTER INDEX "Curso_tipoCursoId_unique" RENAME TO "Curso_tipoCursoId_key";

-- RenameIndex
ALTER INDEX "CursosActivos_salaId_unique" RENAME TO "CursosActivos_salaId_key";

-- RenameIndex
ALTER INDEX "Personal.nroDocumento_unique" RENAME TO "Personal_nroDocumento_key";
