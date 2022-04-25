/*
  Warnings:

  - You are about to drop the column `personalId` on the `LocalidadOnCurso` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_personalId_fkey";

-- AlterTable
ALTER TABLE "Curso" ADD COLUMN     "personalId" INTEGER NOT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE "LocalidadOnCurso" DROP COLUMN "personalId";

-- AddForeignKey
ALTER TABLE "Curso" ADD CONSTRAINT "Curso_personalId_fkey" FOREIGN KEY ("personalId") REFERENCES "Personal"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
