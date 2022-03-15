/*
  Warnings:

  - You are about to drop the `_CursoToDestinatarios` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_CursoToDestinatarios" DROP CONSTRAINT "_CursoToDestinatarios_A_fkey";

-- DropForeignKey
ALTER TABLE "_CursoToDestinatarios" DROP CONSTRAINT "_CursoToDestinatarios_B_fkey";

-- DropTable
DROP TABLE "_CursoToDestinatarios";

-- CreateTable
CREATE TABLE "DestinatarioOnCurso" (
    "cursoId" INTEGER NOT NULL,
    "destinatarioId" INTEGER NOT NULL,
    "descripcion" TEXT NOT NULL,

    PRIMARY KEY ("cursoId","destinatarioId")
);

-- AddForeignKey
ALTER TABLE "DestinatarioOnCurso" ADD FOREIGN KEY ("cursoId") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DestinatarioOnCurso" ADD FOREIGN KEY ("destinatarioId") REFERENCES "Destinatarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;
