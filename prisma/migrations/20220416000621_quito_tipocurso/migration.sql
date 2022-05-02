-- DropForeignKey
ALTER TABLE "Curso" DROP CONSTRAINT "Curso_personalId_fkey";

-- DropForeignKey
ALTER TABLE "Curso" DROP CONSTRAINT "Curso_tipoCursoId_fkey";

-- AddForeignKey
ALTER TABLE "Curso" ADD CONSTRAINT "Curso_tipoCursoId_fkey" FOREIGN KEY ("tipoCursoId") REFERENCES "TipoCurso"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Curso" ADD CONSTRAINT "Curso_personalId_fkey" FOREIGN KEY ("personalId") REFERENCES "Personal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
