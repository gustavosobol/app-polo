/*
  Warnings:

  - You are about to drop the column `personalId` on the `Curso` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Curso" DROP CONSTRAINT "Curso_personalId_fkey";

-- AlterTable
ALTER TABLE "Curso" DROP COLUMN "personalId";

-- AlterTable
ALTER TABLE "LocalidadOnCurso" ADD COLUMN     "personalId" INTEGER NOT NULL DEFAULT 1;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD CONSTRAINT "LocalidadOnCurso_personalId_fkey" FOREIGN KEY ("personalId") REFERENCES "Personal"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
