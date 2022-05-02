/*
  Warnings:

  - You are about to drop the column `horario` on the `CursosActivos` table. All the data in the column will be lost.
  - Added the required column `dia_horario` to the `CursosActivos` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Curso" DROP CONSTRAINT "Curso_personalId_fkey";

-- DropForeignKey
ALTER TABLE "Curso" DROP CONSTRAINT "Curso_tipoCursoId_fkey";

-- AlterTable
ALTER TABLE "CursosActivos" DROP COLUMN "horario",
ADD COLUMN     "dia_horario" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "Curso" ADD CONSTRAINT "Curso_tipoCursoId_fkey" FOREIGN KEY ("tipoCursoId") REFERENCES "TipoCurso"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Curso" ADD CONSTRAINT "Curso_personalId_fkey" FOREIGN KEY ("personalId") REFERENCES "Personal"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
