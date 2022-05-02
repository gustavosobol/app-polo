/*
  Warnings:

  - You are about to drop the `DestinatarioOnCurso` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "DestinatarioOnCurso" DROP CONSTRAINT "DestinatarioOnCurso_cursoId_fkey";

-- DropForeignKey
ALTER TABLE "DestinatarioOnCurso" DROP CONSTRAINT "DestinatarioOnCurso_destinatarioId_fkey";

-- DropTable
DROP TABLE "DestinatarioOnCurso";
