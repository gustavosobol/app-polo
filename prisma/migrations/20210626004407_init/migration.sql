/*
  Warnings:

  - Made the column `nombre` on table `Localidad` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Localidad" ALTER COLUMN "nombre" SET NOT NULL;

-- CreateTable
CREATE TABLE "Destinatarios" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Curso" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_CursoToLocalidad" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_CursoToDestinatarios" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_CursoToLocalidad_AB_unique" ON "_CursoToLocalidad"("A", "B");

-- CreateIndex
CREATE INDEX "_CursoToLocalidad_B_index" ON "_CursoToLocalidad"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CursoToDestinatarios_AB_unique" ON "_CursoToDestinatarios"("A", "B");

-- CreateIndex
CREATE INDEX "_CursoToDestinatarios_B_index" ON "_CursoToDestinatarios"("B");

-- AddForeignKey
ALTER TABLE "_CursoToLocalidad" ADD FOREIGN KEY ("A") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CursoToLocalidad" ADD FOREIGN KEY ("B") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CursoToDestinatarios" ADD FOREIGN KEY ("A") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CursoToDestinatarios" ADD FOREIGN KEY ("B") REFERENCES "Destinatarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;
