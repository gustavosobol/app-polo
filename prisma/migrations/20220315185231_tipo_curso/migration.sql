/*
  Warnings:

  - A unique constraint covering the columns `[tipoCursoId]` on the table `Curso` will be added. If there are existing duplicate values, this will fail.
  - Made the column `tipoCursoId` on table `Curso` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Curso" ALTER COLUMN "tipoCursoId" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Curso_tipoCursoId_unique" ON "Curso"("tipoCursoId");

-- AddForeignKey
ALTER TABLE "Curso" ADD FOREIGN KEY ("tipoCursoId") REFERENCES "TipoCurso"("id") ON DELETE CASCADE ON UPDATE CASCADE;
