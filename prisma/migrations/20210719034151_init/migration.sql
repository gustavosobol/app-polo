/*
  Warnings:

  - Added the required column `cursoCurActId` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `localidadCurActId` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "CursosActivos" ADD COLUMN     "cursoCurActId" INTEGER NOT NULL,
ADD COLUMN     "localidadCurActId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("cursoCurActId") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("localidadCurActId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
