/*
  Warnings:

  - Added the required column `nombreMostrar` to the `LocalidadOnCurso` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "LocalidadOnCurso" ADD COLUMN     "nombreMostrar" TEXT NOT NULL;
