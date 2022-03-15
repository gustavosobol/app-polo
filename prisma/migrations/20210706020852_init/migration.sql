-- CreateTable
CREATE TABLE "AlumnoOnCursoActivo" (
    "cursoActivoId" INTEGER NOT NULL,
    "alumnoId" INTEGER NOT NULL,
    "descripcion" TEXT NOT NULL,

    PRIMARY KEY ("cursoActivoId","alumnoId")
);

-- AddForeignKey
ALTER TABLE "AlumnoOnCursoActivo" ADD FOREIGN KEY ("cursoActivoId") REFERENCES "CursosActivos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AlumnoOnCursoActivo" ADD FOREIGN KEY ("alumnoId") REFERENCES "Alumno"("id") ON DELETE CASCADE ON UPDATE CASCADE;
