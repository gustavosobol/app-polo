-- CreateTable
CREATE TABLE "Usuarios" (
    "id" SERIAL NOT NULL,
    "user" TEXT NOT NULL,
    "nombreMostrar" TEXT NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "Usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Perfiles" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "Perfiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UsuariosOnPerfiles" (
    "usuarioId" INTEGER NOT NULL,
    "perfilId" INTEGER NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "UsuariosOnPerfiles_pkey" PRIMARY KEY ("usuarioId","perfilId")
);

-- AddForeignKey
ALTER TABLE "UsuariosOnPerfiles" ADD CONSTRAINT "UsuariosOnPerfiles_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuarios"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsuariosOnPerfiles" ADD CONSTRAINT "UsuariosOnPerfiles_perfilId_fkey" FOREIGN KEY ("perfilId") REFERENCES "Perfiles"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
