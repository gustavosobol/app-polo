/*
  Warnings:

  - Added the required column `personalId` to the `Curso` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Curso" ADD COLUMN     "personalId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Curso" ADD CONSTRAINT "Curso_personalId_fkey" FOREIGN KEY ("personalId") REFERENCES "Personal"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
