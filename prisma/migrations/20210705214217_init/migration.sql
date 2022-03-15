/*
  Warnings:

  - You are about to drop the `_CursoToLocalidad` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_CursoToLocalidad" DROP CONSTRAINT "_CursoToLocalidad_A_fkey";

-- DropForeignKey
ALTER TABLE "_CursoToLocalidad" DROP CONSTRAINT "_CursoToLocalidad_B_fkey";

-- DropTable
DROP TABLE "_CursoToLocalidad";

-- CreateTable
CREATE TABLE "LocalidadOnCurso" (
    "cursoId" INTEGER NOT NULL,
    "localidadId" INTEGER NOT NULL,
    "descripcion" TEXT NOT NULL,

    PRIMARY KEY ("cursoId","localidadId")
);

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD FOREIGN KEY ("cursoId") REFERENCES "Curso"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocalidadOnCurso" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;
