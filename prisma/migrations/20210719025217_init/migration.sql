/*
  Warnings:

  - Made the column `cursoId` on table `CursosActivos` required. This step will fail if there are existing NULL values in that column.
  - Made the column `localidadId` on table `CursosActivos` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "CursosActivos" ALTER COLUMN "cursoId" SET NOT NULL,
ALTER COLUMN "localidadId" SET NOT NULL;
