-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_cursoId_destinatarioId_fkey";

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD CONSTRAINT "LocalidadOnCurso_destinatarioId_fkey" FOREIGN KEY ("destinatarioId") REFERENCES "Destinatarios"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
