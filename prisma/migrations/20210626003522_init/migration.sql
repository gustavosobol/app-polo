/*
  Warnings:

  - You are about to drop the `Student` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Student" DROP CONSTRAINT "Student_localidadId_fkey";

-- DropTable
DROP TABLE "Student";

-- CreateTable
CREATE TABLE "Alumno" (
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

-- AddForeignKey
ALTER TABLE "Alumno" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
