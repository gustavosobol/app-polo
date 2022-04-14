-- AlterTable
ALTER TABLE "AlumnoOnCursoActivo" ALTER COLUMN "descripcion" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Curso" ALTER COLUMN "descripcion" DROP NOT NULL;

-- AlterTable
ALTER TABLE "CursosActivos" ALTER COLUMN "descripcion" DROP NOT NULL;

-- AlterTable
ALTER TABLE "DestinatarioOnCurso" ALTER COLUMN "descripcion" DROP NOT NULL;

-- AlterTable
ALTER TABLE "LocalidadOnCurso" ALTER COLUMN "descripcion" DROP NOT NULL;

-- AlterTable
ALTER TABLE "TipoCurso" ALTER COLUMN "descripcion" DROP NOT NULL;
