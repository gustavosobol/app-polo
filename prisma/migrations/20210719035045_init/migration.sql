/*
  Warnings:

  - You are about to drop the column `cursoCurActId` on the `CursosActivos` table. All the data in the column will be lost.
  - You are about to drop the column `localidadCurActId` on the `CursosActivos` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_cursoCurActId_fkey";

-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_localidadCurActId_fkey";

-- AlterTable
ALTER TABLE "CursosActivos" DROP COLUMN "cursoCurActId",
DROP COLUMN "localidadCurActId";
