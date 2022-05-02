/*
  Warnings:

  - A unique constraint covering the columns `[personalId]` on the table `LocalidadOnCurso` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "LocalidadOnCurso_personalId_key" ON "LocalidadOnCurso"("personalId");
