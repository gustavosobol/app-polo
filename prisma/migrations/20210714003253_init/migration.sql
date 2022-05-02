/*
  Warnings:

  - You are about to drop the column `nombre` on the `CursosActivos` table. All the data in the column will be lost.
  - Added the required column `nombreMostrar` to the `AlumnoOnCursoActivo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombreMostrar` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombreMostrar` to the `DestinatarioOnCurso` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "AlumnoOnCursoActivo" ADD COLUMN     "nombreMostrar" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "CursosActivos" DROP COLUMN "nombre",
ADD COLUMN     "nombreMostrar" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "DestinatarioOnCurso" ADD COLUMN     "nombreMostrar" TEXT NOT NULL;
