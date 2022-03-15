/*
  Warnings:

  - A unique constraint covering the columns `[nroDocumento]` on the table `Alumno` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Alumno.nroDocumento_unique" ON "Alumno"("nroDocumento");
