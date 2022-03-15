/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Profile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Profile" DROP CONSTRAINT "Profile_userId_fkey";

-- DropTable
DROP TABLE "Post";

-- DropTable
DROP TABLE "Profile";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Student" (
    "id" SERIAL NOT NULL,
    "nroDocumento" INTEGER NOT NULL,
    "apellido" TEXT,
    "nombre" TEXT,
    "fechaNacimiento" DATE NOT NULL,
    "email" TEXT NOT NULL,
    "celular" INTEGER,
    "domicilio" TEXT,
    "barrio" TEXT NOT NULL,
    "localidadId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Localidad" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT,

    PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Student" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
