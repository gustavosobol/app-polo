/*
  Warnings:

  - Added the required column `personalId` to the `Curso` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Curso" ADD COLUMN     "personalId" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "Personal" (
    "id" SERIAL NOT NULL,
    "nroDocumento" INTEGER NOT NULL,
    "apellido" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "fechaNacimiento" DATE NOT NULL,
    "email" TEXT NOT NULL,
    "celular" INTEGER NOT NULL,
    "domicilio" TEXT NOT NULL,
    "barrio" TEXT,
    "localidadId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Personal.nroDocumento_unique" ON "Personal"("nroDocumento");

-- AddForeignKey
ALTER TABLE "Curso" ADD FOREIGN KEY ("personalId") REFERENCES "Personal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Personal" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
