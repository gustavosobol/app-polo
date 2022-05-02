/*
  Warnings:

  - You are about to drop the column `localidadId` on the `Salas` table. All the data in the column will be lost.
  - Added the required column `localidadSalasId` to the `Salas` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Salas" DROP CONSTRAINT "Salas_localidadId_fkey";

-- AlterTable
ALTER TABLE "Salas" DROP COLUMN "localidadId",
ADD COLUMN     "localidadSalasId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Salas" ADD FOREIGN KEY ("localidadSalasId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
