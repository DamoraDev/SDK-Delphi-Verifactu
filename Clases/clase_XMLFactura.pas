unit clase_XMLFactura;
 //DaMoRaDEV, SDK VeriFactu 0.1.5
 //Función GenerarXML optimizada por MSCopilot : simplificacion de variables
interface

uses Classes, System.SysUtils, Unidad_Logica, XML.XMLDoc, XML.XMLIntf, XML.xmldom, MSXMLDOM,
     clase_cabecera,clase_RegistroAlta,clase_ImporteRectificacion, vcl.Dialogs;

type IXMLFactura = Interface
    ['{2B59636A-B8A7-4EFB-A591-571D6E830919}']
    Function GenearXML(cantidadfacturas:integer;cabecera:Tcabecera;RegistroAlta:TRegistroAlta):IXMLDocument;
End;

type TXMLFactura = class (TInterfacedObject,IXMLFactura)
     private
     public
     Function GenearXML(cantidadfacturas:integer;cabecera:Tcabecera;RegistroAlta:TRegistroAlta):IXMLDocument;
end;
type
  TFacturasArray = array of TXMLFactura;
  {
                **************** array de facturas *******************

   procedure GenerarFacturas(cantidadFacturas: integer; cabecera: TCabecera; registroAlta: TRegistroAlta);
    var
      facturas: TFacturasArray;
      i: integer;
      xmlDoc: IXMLDocument;
    begin
      // Configurar la longitud del array dinámico
      SetLength(facturas, cantidadFacturas);
      // Generar el XML para cada factura
      for i := 0 to cantidadFacturas - 1 do
      begin
        facturas[i] := TXMLFactura.Create;
        xmlDoc := facturas[i].GenerarXML(i + 1, cabecera, registroAlta);
        // Guardar el XML en disco o realizar otras operaciones necesarias
        xmlDoc.SaveToFile(Format('factura%d.xml', [i + 1]));
      end;
end;


  }
implementation

function TXMLFactura.GenearXML(cantidadfacturas: integer; cabecera: TCabecera;
         RegistroAlta: TRegistroAlta): IXMLDocument;
var
  XMLDoc: IXMLDocument;
  nodoFactura, NodoCabecera, nodoRegistroFactura, nodoRegistroAlta: IXMLNode; // nodos principales
  contador: string;
  filename:string;
begin
  XMLDoc := TXMLDocument.Create(nil);
  try
    XMLDoc.Active := true;
    XMLDoc.Options := [doNodeAutoIndent];
    // Generar el contador en el formato requerido
   // contador := Format('(%d-1000)', [cantidadfacturas]);
   contador := Format('%d-1000', [cantidadfacturas]);
    // NODO Factura
    nodoFactura := XMLDoc.AddChild('Factura');
    // NODO CABECERA
    NodoCabecera := nodoFactura.AddChild('Cabecera');
    with NodoCabecera.AddChild('ObligadoEmision') do
    begin
      AddChild('NombreRazon').Text := cabecera.ObligadaEmision_NombreRazon;
      AddChild('NIF').Text := cabecera.ObligadaEmision_NIF;
    end;
    if cabecera.UsaRepresentante then
    begin
      with NodoCabecera.AddChild('Representante') do
      begin
        AddChild('NombreRazon').Text := cabecera.Representante_NombreRazon;
        AddChild('NIF').Text := cabecera.Representante_NIF;
      end;
    end;
    if cabecera.HayIncidencia then
    begin
      with NodoCabecera.AddChild('RemisionVoluntaria') do
      begin
        AddChild('FechaFinVerifactu').Text := FormatDateTime('dd-mm-yyyy', cabecera.RemisionVoluntaria_FechaFinVerifactu);
        AddChild('Incidencia').Text := cabecera.RemisionVoluntaria_Incidencia;
      end;
    end;
     // remision requerimiento no esta implementado  revisar
    if Cabecera.RequeridoporEAT= true then
      Begin
        with NodoCabecera.AddChild('RemisionRequerimiento') do
           Begin
             addChild('RefRequerimiento').Text:=Cabecera.RemisionRequerimiento_RefRequerimiento;
             addChild('FinRequerimiento').Text:=Cabecera.RemisionRequerimiento_FinRequerimiento;
           End;
      End;
    // NODO RegistroFactura
    nodoRegistroFactura := nodoFactura.AddChild('RegistroFactura');
    nodoRegistroFactura.Attributes['num'] := contador;
    // NODO RegistroAlta
    nodoRegistroAlta := nodoRegistroFactura.AddChild('RegistroAlta');
    nodoRegistroAlta.AddChild('IDVersion').Text := RegistroAlta.IDVersion;
    // SUBNODO IDFactura
    with nodoRegistroAlta.AddChild('IDFactura') do
    begin
      AddChild('IDEmisorFactura').Text := RegistroAlta.IDFactura.IDEmisorFactura;
      AddChild('NumSerieFactura').Text := RegistroAlta.IDFactura.NumSerieFactura;
      AddChild('FechaExpedicionFactura').Text := FormatDateTime('dd-mm-yyyy', RegistroAlta.IDFactura.FechaExpedicionFactura);
    end;
    nodoRegistroAlta.AddChild('RefExterna').Text := RegistroAlta.RefExterna;
    nodoRegistroAlta.AddChild('NombreRazonEmisor').Text := RegistroAlta.NombreRazonEmisor;
    nodoRegistroAlta.AddChild('Subsanacion').Text := RegistroAlta.GETSubsanacion;
    nodoRegistroAlta.AddChild('RechazoPrevio').Text := RegistroAlta.GETRechazoPrevio;
    nodoRegistroAlta.AddChild('TipoFactura').Text := RegistroAlta.TipoFactura ;
    nodoRegistroAlta.AddChild('TipoRectificativa').Text := RegistroAlta.TipoRectificativa;
    // SUBNODO Facturas Rectificadas  verificado xml sin error
    if RegistroAlta.FacturasRectificadas.NodoNecesario = true  then
    Begin
      with nodoRegistroAlta.AddChild('FacturasRectificadas') do
        begin
          with AddChild('IDFacturaRectificada') do
            begin
              AddChild('IDEmisorFactura').Text := RegistroAlta.FacturasRectificadas.IDEmisorFactura;
              AddChild('NumSerieFactura').Text := RegistroAlta.FacturasRectificadas.NumSerieFactura;
              AddChild('FechaExpedicionFactura').Text := FormatDateTime('dd-mm-yyyy', RegistroAlta.FacturasRectificadas.FechaExpedicionFactura);
            end;
        end;
    End;
    // SUBNODO Facturas Sustituidas añadir la cantidad (1-1000);
    if RegistroAlta.FacturasSustituidas.NodoNecesario = true then
    Begin
      with nodoRegistroAlta do // debe indicar la cantidad 1-1000
        begin
         AddChild('FacturasSustituidas').Attributes['num']:=IntToStr(RegistroAlta.FacturasSustituidas.CantidadFacturas)+'-1000';
         with  ChildNodes['FacturasSustituidas'].addChild('IDFacturaSustituida') do
           begin
             AddChild('IDEmisorFactura').Text := RegistroAlta.FacturasSustituidas.IDEmisorFactura;
             AddChild('NumSerieFactura').Text := RegistroAlta.FacturasSustituidas.NumSerieFactura;
             AddChild('FechaExpedicionFactura').Text := FormatDateTime('dd-mm-yyyy', RegistroAlta.FacturasSustituidas.FechaExpedicionFactura);
           end;
        end;
    End;
    // SUBNodo ImporteRectificacion   Acces violation 028
    if Assigned(RegistroAlta.ImporteRectificacion) then
    begin
      if (RegistroAlta.FacturasRectificadas.NodoNecesario = True) and (RegistroAlta.ImporteRectificacion.NodoNecesario = True) then
      begin
        with nodoRegistroAlta.AddChild('ImporteRectificacion') do
        begin
          AddChild('BaseRectificada').Text := FloatToStr(RegistroAlta.ImporteRectificacion.BaseRectificada);
          AddChild('CuotaRectificada').Text := FloatToStr(RegistroAlta.ImporteRectificacion.CuotaRectificada);
          AddChild('CuotaRecargoRectificado').Text := FloatToStr(RegistroAlta.ImporteRectificacion.CuotaRecargoRectificado);
        end;
      end ;
     end;


    // Subnodos varios
   // nodoRegistroAlta.AddChild('FechaOperacion').Text := FormatDateTime('dd-mm-yyyy',now);
   // nodoRegistroAlta.AddChild('DescripcionOperacion').Text := RegistroAlta
    // Guardar el XML en disco
    nodoRegistroAlta.AddChild('FechaOperacion').Text := FormatDateTime('dd-mm-yyyy',RegistroAlta.FechaOperacion);
    nodoRegistroALta.AddChild('DescripcionOperacion').Text := RegistroAlta.DescripcionOperacion;
    nodoRegistroAlta.AddChild('FacturaSimplificadaArt7273').Text := RegistroAlta.FacturaSimplificadaArt7273;
    nodoRegistroAlta.AddChild('FacturaSinIdentifDestinatarioArt61d').Text := RegistroAlta.FacturaSinIdentifDestinatarioArt61d;
    nodoRegistroAlta.AddChild('Macrodato').Text := RegistroAlta.Macrodato ;
    nodoRegistroAlta.AddChild('EmitidaPorTerceroDestinatario').Text := Registroalta.EmitidaPorTerceroDestinatario;

                    { Nodo Tercero  }

    if (RegistroAlta.Tercero.NodoNecesario = true ) then
        Begin
          with nodoRegistroAlta.AddChild('Tercero') do
          begin
              addchild('NombreRazon').Text := RegistroAlta.Tercero.NombreRazon;
              addChild('NIF').Text:= RegistroAlta.Tercero.NIF;
              with addchild('IDOtro') do
              begin
                 addchild('CodigoPais').Text:= RegistroAlta.Tercero.IDOtro_CodigoPais;
                 addchild('IDType').Text := RegistroAlta.Tercero.IDOtro_IDType;
                 addChild('ID').Text := RegistroAlta.Tercero.IDOtro_ID;
              end;
          end;
        End;

                    { nodo Destinatarios }

    if (RegistroAlta.Destinatarios.NodoNecesario = true) then
    begin
       with nodoRegistroAlta.AddChild('Destinatarios') do
          begin
            addchild('IDDestinatario').attributes['num'] :=IntToStr( RegistroAlta.Destinatarios.CantidadDestinatarios)+'-1000' ;
            childNodes['IDDestinatario'].AddChild('NombreRazon').Text := RegistroAlta.Destinatarios.NombreRazon;
            childNodes['IDDestinatario'].AddChild('NIF').Text:=RegistroAlta.Destinatarios.NIF;
            with ChildNodes['IDDestinatario'].AddChild('IDotro')do
               begin
                 addchild('CodigoPais').Text:= RegistroAlta.Destinatarios.IDOtro_CodigoPais;
                 addchild('IDType').Text := RegistroAlta.Destinatarios.IDOtro_IDType;
                 addChild('ID').Text := RegistroAlta.Destinatarios.IDOtro_ID;
               end;
          end;

    end;
    nodoRegistroAlta.AddChild('Cupon').Text:= RegistroAlta.Cupon;

                                {  Desglose  }
    with NodoRegistroAlta do
    Begin
       AddChild('Desglose').Attributes['num'] := IntToStr( RegistroAlta.Desglose.CantidadDesglose)+'-12';
       childNodes['Desglose'].addchild('Impuesto').Text := RegistroAlta.Desglose.ValorImpuesto;
       childNodes['Desglose'].addchild('ClaveRegimen').Text := RegistroAlta.Desglose.ClaveRegimen;
       childNodes['Desglose'].AddChild('CalificacionOperacion').Text := RegistroAlta.Desglose.CalificacionOperacion;
       if RegistroAlta.Desglose.OperacionExenta<>'' then
                childNodes['Desglose'].AddChild('OperacionExenta').Text := RegistroAlta.Desglose.OperacionExenta;
       childNodes['Desglose'].AddChild('TipoImpositivo').Text := FloatToStr( RegistroAlta.Desglose.TipoImpositivo );
       childNodes['Desglose'].AddChild('BaseImponibleOImporteNoSujeto').Text :=FloatToStr(RegistroAlta.Desglose.BaseImponibleOImporteNoSujeto);
       childNodes['Desglose'].AddChild('BaseImponibleACoste').Text := FloatToStr( RegistroAlta.Desglose.BaseImponibleACoste);
       childNodes['Desglose'].AddChild('CuotaRepercutida').Text := FloatToStr( RegistroAlta.Desglose.CuotaRepercutida );
       ChildNodes['Desglose'].AddChild('TipoRecargoEquivalencia').Text := FloatToStr(RegistroAlta.Desglose.TipoRecargoEquivalencia);
       ChildNodes['Desglose'].AddChild('CuotaRecargoEquivalencia').Text := FloatToStr(RegistroAlta.Desglose.CuotaRecargoEquivalencia);
    End;
                                  { Encadenamiento }
    if RegistroAlta.Encadenamiento.GETHayRegistroAnterior=true then
        Begin
          with NodoRegistroAlta.AddChild('Encadenamiento') do
             Begin
               AddChild('PrimerRegistro').Text:= RegistroAlta.Encadenamiento.PrimerRegistro;
               AddChild('RegistroAnterior');
               ChildNodes['RegistroAnterior'].AddChild('IDEmisorFactura').Text := RegistroAlta.Encadenamiento.RegistroAnterior_IDEmisorFactura;
               childNodes['RegistroAnterior'].AddChild('NumSerieFactura').Text := RegistroAlta.Encadenamiento.RegistroAnterior_NumSerieFactura;
               childNodes['RegistroAnterior'].AddChild('FechaExpedicionFactura').Text := FormatDateTime('dd-mm-yyyy',RegistroAlta.Encadenamiento.RegistroAnterior_FechaExpedicionFactura);
               childNodes['RegistroAnterior'].AddChild('Huella').Text := RegistroAlta.Encadenamiento.RegistroAnterior_Huella;
             End
          end
          else
           begin
             with NodoRegistroAlta.AddChild('Encadenamiento') do
                begin
                  AddChild('PrimerRegistro').Text:=RegistroAlta.Encadenamiento.PrimerRegistro;
                end;
           end;

    //fileName := Format('factura_%d_%s.xml', [cantidadFacturas, TVersion.NumeroVersion]);
    fileName := Format('factura_%d.xml', [cantidadFacturas]);
    XMLDoc.SaveToFile(fileName);
  except
    on E: Exception do
      raise Exception.Create('Error al crear el XML: ' + E.ToString);
  end;
  Result := XMLDoc;
end;


end.
