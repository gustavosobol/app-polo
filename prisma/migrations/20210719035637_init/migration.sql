-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_localidadId_cursoId_fkey";

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("localidadId", "cursoId") REFERENCES "LocalidadOnCurso"("localidadId", "cursoId") ON DELETE SET NULL ON UPDATE CASCADE;
