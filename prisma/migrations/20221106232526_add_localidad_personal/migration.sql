-- AddForeignKey
ALTER TABLE "Personal" ADD CONSTRAINT "Personal_localidadId_fkey" FOREIGN KEY ("localidadId") REFERENCES "Localidad"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
