/*
  Warnings:

  - You are about to drop the column `localidadIdPerso` on the `Personal` table. All the data in the column will be lost.
  - Added the required column `localidadId` to the `Personal` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Personal" DROP CONSTRAINT "Personal_localidadIdPerso_fkey";

-- AlterTable
ALTER TABLE "Personal" DROP COLUMN "localidadIdPerso",
ADD COLUMN     "localidadId" INTEGER NOT NULL;
