unit clase_RegistroFactura;
//DaMoRaDEV, SDK VeriFactu 0.1.0
   {
    El Nodo Registro factura lleva contador (1-1000);
    RegistroAlta
    RegistroAnulacion
    Eventos
   }
interface
uses  Classes, Sysutils,
      clase_RegistroAlta,
      clase_Destinatarios,
      clase_importeRectificacion,
      unidad_logica;
Type IRegistroFactura = Interface
  ['{A6A860E3-6C26-422A-A6E0-5FD441C86929}']
End;
Type TRegistroFactura = Class (TInterfacedObject,IRegistroFactura)
     Private
       FRegistroAlta:TRegistroAlta;
       FTipoFacturaRectificada:string;
       // indica el tipo de la factura anterior
      // FRegistroAnulacion:TRegistroAnulacion
      // FEvento:Teventos
     Public
     Property TipoFacturaRectificada:string read FTipoFacturaRectificada write FTipoFacturaRectificada;
     Procedure LogicaFactura(RegistroAlta:TRegistroAlta;Destinatarios:TDestinatarios;ImporteRectificacion:TImporteRectificacion);
End;
implementation

                            { Logica de la factura }

 Procedure TRegistroFactura.LogicaFactura(RegistroAlta:TRegistroAlta;Destinatarios:TDestinatarios;ImporteRectificacion:TImporteRectificacion);
 Begin
   if RegistroAlta.TipoFactura ='F1' then
       Begin
          if FTipoFacturaRectificada='F2' then
              Begin
                 // en este caso no hay destinatario ya que rectifica
                 //una factura F2
                 if Destinatarios.NodoNecesario=True then
                     raise Exception.Create('Error LogicaFactura: Este tipo de factura NO requiere Destinatario ');
              End
          else
              Begin
                   // la factura F1 requiere destinatario
                 if Destinatarios.NodoNecesario = false then
                      raise Exception.Create('Error LogicaFactura: Este tipo de factura requiere Destinatario ');
              End;
       End;
   if RegistroAlta.TipoFactura ='F2' then
      Begin
         // Fe simplificada no tien destinatarios
         if Destinatarios.NodoNecesario=true then
            raise Exception.Create('Error LogicaFactura: La factura F2 no requiere Destinatarios');
      End;
   if RegistroAlta.TipoFactura ='F3'  then
     Begin
       //Factura emitida en sustitucion de una F2
       if FTipoFacturaRectificada='F2' then
            if Destinatarios.NodoNecesario=true then
                  raise Exception.Create('Error LogicaFactura: La factura FF no requiere Destinatarios ya que sustituye a F2');
     End;
   if RegistroAlta.TipoFactura ='R1' then
   Begin
        if Destinatarios.NodoNecesario = False then
          raise Exception.Create('Error LogicaFactura: La factura R1 requiere de Destinatarios');
        if ImporteRectificacion.NodoNecesario= false then
          raise Exception.Create('Error LogicaFactura: La Factura R1 requiere ImporteRectificacion');
        if (RegistroAlta.Subsanacion<>'S') then
          raise Exception.Create('Error LogicaFactura: La Factura R1 requiere Subsanacion S');

      // No necesitan Fecha de la operacion si pertenece al periodo corriente
   End;
      if RegistroAlta.TipoFactura ='R2' then
   Begin
    if Destinatarios.NodoNecesario = False then
          raise Exception.Create('Error LogicaFactura: La factura R2 requiere de Destinatarios');
        if ImporteRectificacion.NodoNecesario= false then
          raise Exception.Create('Error LogicaFactura: La Factura R2 requiere ImporteRectificacion');
        if (RegistroAlta.Subsanacion<>'S') then
          raise Exception.Create('Error LogicaFactura: La Factura R2 requiere Subsanacion S');
      // No necesitan Fecha de la operacion si pertenece al periodo corriente
   End;
      if RegistroAlta.TipoFactura ='R3' then
   Begin
        if Destinatarios.NodoNecesario = False then
          raise Exception.Create('Error LogicaFactura: La factura R3 requiere de Destinatarios');
        if ImporteRectificacion.NodoNecesario= false then
          raise Exception.Create('Error LogicaFactura: La Factura R3 requiere ImporteRectificacion');
        if (RegistroAlta.Subsanacion<>'S') then
          raise Exception.Create('Error LogicaFactura: La Factura R3 requiere Subsanacion S');
      // No necesitan Fecha de la operacion si pertenece al periodo corriente
   End;
      if RegistroAlta.TipoFactura ='R4' then
   Begin
        if Destinatarios.NodoNecesario = False then
          raise Exception.Create('Error LogicaFactura: La factura R4 requiere de Destinatarios');
        if ImporteRectificacion.NodoNecesario= false then
          raise Exception.Create('Error LogicaFactura: La Factura R4 requiere ImporteRectificacion');
        if (RegistroAlta.Subsanacion<>'S') then
          raise Exception.Create('Error LogicaFactura: La Factura R4 requiere Subsanacion S');
     // No necesitan Fecha de la operacion si pertenece al periodo corriente
   End;
   if RegistroAlta.TipoFactura ='R5' then
   Begin
        if (FTipoFacturaRectificada='F2')AND (RegistroAlta.Subsanacion='S') then
            Begin
              if Destinatarios.NodoNecesario = False then
                raise Exception.Create('Error LogicaFactura: La factura R5 requiere de Destinatarios');
              if ImporteRectificacion.NodoNecesario= false then
                raise Exception.Create('Error LogicaFactura: La Factura R5 requiere ImporteRectificacion');
              if (RegistroAlta.Subsanacion<>'S') then
                raise Exception.Create('Error LogicaFactura: La Factura R5 requiere Subsanacion S');
            end
        else raise Exception.Create('Error LogicaFactura: La factura R5 es una sustitucion de una factura F2 Simplificada');

     // Sustitucion S de una F2 (simplificada)
     // deben llevar BaseImponible,Cuota y en su caso Recargo
     // deben llevar BaseRectificada, CuotaRectificada y RecargoRectificado
   End;
 End;
end.
