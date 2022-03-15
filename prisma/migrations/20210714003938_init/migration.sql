/*
  Warnings:

  - Added the required column `cursoActivoId` to the `LocalidadOnCurso` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "LocalidadOnCurso" ADD COLUMN     "cursoActivoId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD FOREIGN KEY ("cursoActivoId") REFERENCES "CursosActivos"("id") ON DELETE CASCADE ON UPDATE CASCADE;
