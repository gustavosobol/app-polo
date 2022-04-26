/*
  Warnings:

  - You are about to drop the column `localidadId` on the `Personal` table. All the data in the column will be lost.
  - Added the required column `localidadIdPerso` to the `Personal` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Personal" DROP CONSTRAINT "Personal_localidadId_fkey";

-- AlterTable
ALTER TABLE "LocalidadOnCurso" ALTER COLUMN "destinatarioId" DROP DEFAULT;

-- AlterTable
ALTER TABLE "Personal" DROP COLUMN "localidadId",
ADD COLUMN     "localidadIdPerso" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Personal" ADD CONSTRAINT "Personal_localidadIdPerso_fkey" FOREIGN KEY ("localidadIdPerso") REFERENCES "Localidad"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
