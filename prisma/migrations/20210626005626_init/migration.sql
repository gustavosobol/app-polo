-- CreateTable
CREATE TABLE "Salas" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,
    "localidadId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CursosActivos" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "activo" BOOLEAN NOT NULL,
    "fechaInicio" DATE NOT NULL,
    "fechaFin" DATE NOT NULL,
    "horario" TEXT NOT NULL,
    "cupos" INTEGER NOT NULL,
    "descripcion" TEXT NOT NULL,
    "salaId" INTEGER,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CursosActivos_salaId_unique" ON "CursosActivos"("salaId");

-- AddForeignKey
ALTER TABLE "Salas" ADD FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursosActivos" ADD FOREIGN KEY ("salaId") REFERENCES "Salas"("id") ON DELETE SET NULL ON UPDATE CASCADE;
