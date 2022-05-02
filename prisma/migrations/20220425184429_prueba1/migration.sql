/*
  Warnings:

  - You are about to drop the column `personalId` on the `LocalidadOnCurso` table. All the data in the column will be lost.
  - Added the required column `personalId` to the `Curso` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "LocalidadOnCurso" DROP CONSTRAINT "LocalidadOnCurso_personalId_fkey";

-- AlterTable
ALTER TABLE "Curso" ADD COLUMN     "personalId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "LocalidadOnCurso" DROP COLUMN "personalId";

-- AddForeignKey
ALTER TABLE "Curso" ADD CONSTRAINT "Curso_personalId_fkey" FOREIGN KEY ("personalId") REFERENCES "Personal"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
