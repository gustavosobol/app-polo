/*
  Warnings:

  - You are about to drop the column `localidadCurActId` on the `CursosActivos` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[salaId]` on the table `CursosActivos` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_localidadCurActId_fkey";

-- AlterTable
ALTER TABLE "CursosActivos" DROP COLUMN "localidadCurActId",
ADD COLUMN     "cursoId" INTEGER,
ADD COLUMN     "localidadId" INTEGER;

-- CreateIndex
CREATE UNIQUE INDEX "CursosActivos_salaId_unique" ON "CursosActivos"("salaId");

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("localidadId", "cursoId") REFERENCES "LocalidadOnCurso"("cursoId", "localidadId") ON DELETE SET NULL ON UPDATE CASCADE;
