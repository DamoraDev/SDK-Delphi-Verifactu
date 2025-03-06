unit clase_LogicaFacturav2;
//DaMoRaDEV, SDK VeriFactu 0.1.0
//Optimizada por Copilot
{
  Lógica Factura Basada en el documento de la AEAT:
  FAQs_ver_1_1_facturas.pdf
  Recordamos que es un SDK, esta lógica es aproximada.
  En el diseño del software se debe atender a la lógica
  de la factura que se genera, así como a los cálculos pertinentes de la misma.
}
interface
uses
  Classes, Sysutils,
  clase_RegistroAlta,
  clase_Destinatarios,
  clase_RegistroAnulacion,
  clase_importeRectificacion,
  unidad_logica;
const
  TipoFacturaF1 = 'F1';
  TipoFacturaF2 = 'F2';
  TipoFacturaF3 = 'F3';
  TipoFacturaR1 = 'R1';
  TipoFacturaR2 = 'R2';
  TipoFacturaR3 = 'R3';
  TipoFacturaR4 = 'R4';
  TipoFacturaR5 = 'R5';
type
  ILogicaFactura = interface
    ['{A6A860E3-6C26-422A-A6E0-5FD441C86929}']
  end;
type
  TLogicaFactura = class(TInterfacedObject, ILogicaFactura)
  private
    FRegistroAlta: TRegistroAlta;
    FTipoFacturaAnterior: string; //tipo factura anterior
  public
    property  TipoFacturaAnterior: string read FTipoFacturaAnterior write FTipoFacturaAnterior;
    procedure LogicaRegistroAlta(RegistroAlta: TRegistroAlta; Destinatarios: TDestinatarios; ImporteRectificacion: TImporteRectificacion);
    Procedure LogicaAltaYAnulacion(ARegistroAlta:TRegistroAlta;ARegistroAnulacion:TRegistroAnulacion);
  end;
implementation

Procedure TLogicaFactura.LogicaAltaYAnulacion(ARegistroAlta: TRegistroAlta; ARegistroAnulacion: TRegistroAnulacion);
Begin
    if (ARegistroAlta.NodoNecesario = True )AND(AregistroAnulacion.NodoNecesario=true) then
         raise Exception.Create('Error Logica AltaYAnulacion: Esta enviando una factura con Alta y Anulación al mismo tiempo.')
    else
    if (ARegistroAlta.NodoNecesario = False)AND(ARegistroAnulacion.NodoNecesario = False) then
         raise Exception.Create('Error Logica AltaYAnulacion: Esta enviando una factura sin RegistroAlta ni RegistroAnulacion.');
End;

                        { TRegistroFactura: Logica de la Factura RegistroAlta}

procedure TLogicaFactura.LogicaRegistroAlta(RegistroAlta: TRegistroAlta; Destinatarios: TDestinatarios; ImporteRectificacion: TImporteRectificacion);
    procedure VerificarDestinatarios(SeRequiere: Boolean);
    begin
        if SeRequiere then
        begin
          if not Destinatarios.NodoNecesario then
            raise Exception.CreateFmt('Error LogicaFactura: El tipo de factura %s requiere destinatarios.', [RegistroAlta.TipoFactura]);
        end
        else
        begin
          if Destinatarios.NodoNecesario then
            raise Exception.CreateFmt('Error LogicaFactura: El tipo de factura %s no requiere destinatarios.', [RegistroAlta.TipoFactura]);
        end;
    end;
    procedure VerificarImporteRectificacion(SeRequiere: Boolean);
    begin
        if SeRequiere then
        begin
          if not ImporteRectificacion.NodoNecesario then
            raise Exception.CreateFmt('Error LogicaFactura: El tipo de factura %s requiere ImporteRectificacion.', [RegistroAlta.TipoFactura]);
        end
        else
        begin
          if ImporteRectificacion.NodoNecesario then
            raise Exception.CreateFmt('Error LogicaFactura: El tipo de factura %s no requiere ImporteRectificacion.', [RegistroAlta.TipoFactura]);
        end;
    end;
    procedure VerificarSubsanacion(SubsanacionEsperada: string);
    begin
      if RegistroAlta.Subsanacion <> SubsanacionEsperada then
        raise Exception.CreateFmt('Error LogicaFactura: El tipo de factura %s requiere Subsanacion %s.', [RegistroAlta.TipoFactura, SubsanacionEsperada]);
    end;
  begin
      if RegistroAlta.TipoFactura = TipoFacturaF1 then
      begin
        if FTipoFacturaAnterior = TipoFacturaF2 then
        begin
          VerificarDestinatarios(False);
        end
        else
        begin
          VerificarDestinatarios(True);
        end;
       end
      else if RegistroAlta.TipoFactura = TipoFacturaF2 then
      begin
        VerificarDestinatarios(False);
      end
      else if RegistroAlta.TipoFactura = TipoFacturaF3 then
      begin
        if FTipoFacturaAnterior = TipoFacturaF2 then
        begin
          VerificarDestinatarios(False);
        end;
      end
      else if (RegistroAlta.TipoFactura = TipoFacturaR1) or
              (RegistroAlta.TipoFactura = TipoFacturaR2) or
              (RegistroAlta.TipoFactura = TipoFacturaR3) or
              (RegistroAlta.TipoFactura = TipoFacturaR4) then
      begin
        VerificarDestinatarios(True);
        VerificarImporteRectificacion(True);
        VerificarSubsanacion('S');
      end
      else if RegistroAlta.TipoFactura = TipoFacturaR5 then
      begin
        if (FTipoFacturaAnterior = TipoFacturaF2) and (RegistroAlta.Subsanacion = 'S') then
        begin
          VerificarDestinatarios(True);
          VerificarImporteRectificacion(True);
          VerificarSubsanacion('S');
        end
        else
          raise Exception.Create('Error LogicaFactura: La factura R5 es una sustitución de una factura F2 Simplificada');
      end;
  end;
end.


