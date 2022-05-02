-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_localidadId_cursoId_fkey";

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("cursoId") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
