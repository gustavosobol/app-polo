/*
  Warnings:

  - You are about to drop the column `localidadId` on the `Alumno` table. All the data in the column will be lost.
  - You are about to drop the column `cursoId` on the `CursosActivos` table. All the data in the column will be lost.
  - You are about to drop the column `localidadId` on the `CursosActivos` table. All the data in the column will be lost.
  - The primary key for the `LocalidadOnCurso` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `cursoId` on the `LocalidadOnCurso` table. All the data in the column will be lost.
  - You are about to drop the column `localidadId` on the `LocalidadOnCurso` table. All the data in the column will be lost.
  - You are about to drop the column `localidadId` on the `Salas` table. All the data in the column will be lost.
  - Added the required column `localidadAlumId` to the `Alumno` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cursoCurActId` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `localidadCurActId` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cursoOnCurId` to the `LocalidadOnCurso` table without a default value. This is not possible if the table is not empty.
  - Added the required column `localidadOnCurId` to the `LocalidadOnCurso` table without a default value. This is not possible if the table is not empty.
  - Added the required column `localidadSalaId` to the `Salas` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Alumno" DROP CONSTRAINT "Alumno_localidadId_fkey";

-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_cursoId_fkey";

-- DropForeignKey
ALTER TABLE "CursosActivos" DROP CONSTRAINT "CursosActivos_localidadId_fkey";

-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_cursoId_fkey";

-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_localidadId_fkey";

-- DropForeignKey
ALTER TABLE "Salas" DROP CONSTRAINT "Salas_localidadId_fkey";

-- AlterTable
ALTER TABLE "Alumno" DROP COLUMN "localidadId",
ADD COLUMN     "localidadAlumId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "CursosActivos" DROP COLUMN "cursoId",
DROP COLUMN "localidadId",
ADD COLUMN     "cursoCurActId" INTEGER NOT NULL,
ADD COLUMN     "localidadCurActId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_pkey",
DROP COLUMN "cursoId",
DROP COLUMN "localidadId",
ADD COLUMN     "cursoOnCurId" INTEGER NOT NULL,
ADD COLUMN     "localidadOnCurId" INTEGER NOT NULL,
ADD PRIMARY KEY ("cursoOnCurId", "localidadOnCurId");

-- AlterTable
ALTER TABLE "Salas" DROP COLUMN "localidadId",
ADD COLUMN     "localidadSalaId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD FOREIGN KEY ("cursoOnCurId") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD FOREIGN KEY ("localidadOnCurId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Alumno" ADD FOREIGN KEY ("localidadAlumId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Salas" ADD FOREIGN KEY ("localidadSalaId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("cursoCurActId") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("localidadCurActId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
