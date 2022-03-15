/*
  Warnings:

  - Made the column `apellido` on table `Student` required. This step will fail if there are existing NULL values in that column.
  - Made the column `nombre` on table `Student` required. This step will fail if there are existing NULL values in that column.
  - Made the column `celular` on table `Student` required. This step will fail if there are existing NULL values in that column.
  - Made the column `domicilio` on table `Student` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Student" ALTER COLUMN "apellido" SET NOT NULL,
ALTER COLUMN "nombre" SET NOT NULL,
ALTER COLUMN "celular" SET NOT NULL,
ALTER COLUMN "domicilio" SET NOT NULL,
ALTER COLUMN "barrio" DROP NOT NULL;
