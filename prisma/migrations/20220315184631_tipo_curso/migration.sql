-- AlterTable
ALTER TABLE "Curso" ADD COLUMN     "tipoCursoId" INTEGER;

-- CreateTable
CREATE TABLE "TipoCurso" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,

    PRIMARY KEY ("id")
);
