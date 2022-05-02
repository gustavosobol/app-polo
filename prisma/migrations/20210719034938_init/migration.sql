/*
  Warnings:

  - You are about to drop the column `cursoId` on the `CursosActivos` table. All the data in the column will be lost.
  - You are about to drop the column `localidadId` on the `CursosActivos` table. All the data in the column will be lost.
  - You are about to drop the column `localidadSalasId` on the `Salas` table. All the data in the column will be lost.
  - Added the required column `cursoCurActId` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `localidadCurActId` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `localidadId` to the `Salas` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_cursoId_fkey";

-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_localidadId_fkey";

-- DropForeignKey
ALTER TABLE "Salas" DROP CONSTRAINT "Salas_localidadSalasId_fkey";

-- AlterTable
ALTER TABLE "CursosActivos" DROP COLUMN "cursoId",
DROP COLUMN "localidadId",
ADD COLUMN     "cursoCurActId" INTEGER NOT NULL,
ADD COLUMN     "localidadCurActId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Salas" DROP COLUMN "localidadSalasId",
ADD COLUMN     "localidadId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Salas" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("cursoCurActId") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("localidadCurActId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
