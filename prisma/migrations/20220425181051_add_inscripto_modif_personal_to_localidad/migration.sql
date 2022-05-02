/*
  Warnings:

  - You are about to drop the column `personalId` on the `LocalidadOnCurso` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_personalId_fkey";

-- AlterTable
ALTER TABLE "LocalidadOnCurso" DROP COLUMN "personalId";
