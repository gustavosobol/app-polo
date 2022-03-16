-- AlterTable
ALTER TABLE "CursosActivos" ADD COLUMN     "turnoId" INTEGER;

-- CreateTable
CREATE TABLE "Turno" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("turnoId") REFERENCES "Turno"("id") ON DELETE SET NULL ON UPDATE CASCADE;
