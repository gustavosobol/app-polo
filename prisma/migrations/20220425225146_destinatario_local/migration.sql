-- AlterTable
ALTER TABLE "LocalidadOnCurso" ADD COLUMN     "destinatarioId" INTEGER NOT NULL DEFAULT 2;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD CONSTRAINT "LocalidadOnCurso_cursoId_destinatarioId_fkey" FOREIGN KEY ("cursoId", "destinatarioId") REFERENCES "DestinatarioOnCurso"("cursoId", "destinatarioId") ON DELETE NO ACTION ON UPDATE CASCADE;
