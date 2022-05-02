/*
  Warnings:

  - Added the required column `edadFin` to the `Destinatarios` table without a default value. This is not possible if the table is not empty.
  - Added the required column `edadInicio` to the `Destinatarios` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Destinatarios" ADD COLUMN     "edadFin" INTEGER NOT NULL,
ADD COLUMN     "edadInicio" INTEGER NOT NULL;
