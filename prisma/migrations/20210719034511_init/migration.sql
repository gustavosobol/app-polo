/*
  Warnings:

  - You are about to drop the column `localidadAlumId` on the `Alumno` table. All the data in the column will be lost.
  - You are about to drop the column `cursoCurActId` on the `CursosActivos` table. All the data in the column will be lost.
  - You are about to drop the column `localidadCurActId` on the `CursosActivos` table. All the data in the column will be lost.
  - The primary key for the `LocalidadOnCurso` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `cursoOnCurId` on the `LocalidadOnCurso` table. All the data in the column will be lost.
  - You are about to drop the column `localidadOnCurId` on the `LocalidadOnCurso` table. All the data in the column will be lost.
  - You are about to drop the column `localidadSalaId` on the `Salas` table. All the data in the column will be lost.
  - Added the required column `localidadId` to the `Alumno` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cursoId` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `localidadId` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cursoId` to the `LocalidadOnCurso` table without a default value. This is not possible if the table is not empty.
  - Added the required column `localidadId` to the `LocalidadOnCurso` table without a default value. This is not possible if the table is not empty.
  - Added the required column `localidadId` to the `Salas` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Alumno" DROP CONSTRAINT "Alumno_localidadAlumId_fkey";

-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_cursoCurActId_fkey";

-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_localidadCurActId_fkey";

-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_cursoOnCurId_fkey";

-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_localidadOnCurId_fkey";

-- DropForeignKey
ALTER TABLE "Salas" DROP CONSTRAINT "Salas_localidadSalaId_fkey";

-- AlterTable
ALTER TABLE "Alumno" DROP COLUMN "localidadAlumId",
ADD COLUMN     "localidadId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "CursosActivos" DROP COLUMN "cursoCurActId",
DROP COLUMN "localidadCurActId",
ADD COLUMN     "cursoId" INTEGER NOT NULL,
ADD COLUMN     "localidadId" INTEGER NOT NULL,
ALTER COLUMN "salaId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_pkey",
DROP COLUMN "cursoOnCurId",
DROP COLUMN "localidadOnCurId",
ADD COLUMN     "cursoId" INTEGER NOT NULL,
ADD COLUMN     "localidadId" INTEGER NOT NULL,
ADD PRIMARY KEY ("cursoId", "localidadId");

-- AlterTable
ALTER TABLE "Salas" DROP COLUMN "localidadSalaId",
ADD COLUMN     "localidadId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD FOREIGN KEY ("cursoId") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Alumno" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Salas" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("cursoId") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
