/*
  Warnings:

  - Made the column `salaId` on table `CursosActivos` required. This step will fail if there are existing NULL values in that column.

*/
-- DropIndex
DROP INDEX "CursosActivos_salaId_unique";

-- AlterTable
ALTER TABLE "CursosActivos" ALTER COLUMN "salaId" SET NOT NULL;
