/*
  Warnings:

  - You are about to drop the column `cursoActivoId` on the `LocalidadOnCurso` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_cursoActivoId_fkey";

-- AlterTable
ALTER TABLE "CursosActivos" ADD COLUMN     "cursoId" INTEGER,
ADD COLUMN     "localidadId" INTEGER;

-- AlterTable
ALTER TABLE "LocalidadOnCurso" DROP COLUMN "cursoActivoId";

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("localidadId", "cursoId") REFERENCES "LocalidadOnCurso"("cursoId", "localidadId") ON DELETE SET NULL ON UPDATE CASCADE;
