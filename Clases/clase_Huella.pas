unit clase_Huella;
 //DaMoRaDEV, SDK VeriFactu 0.1.0
interface
Uses SysUtils, Classes, Xml.XMLDoc, Xml.XMLIntf, shellapi, windows,unidad_logica,
    clase_DatosRegistroAlta,clase_DatosRegistroAnulacion,clase_DatosEventos;




type IHuella = interface
  ['{03702320-414D-4278-9DC6-8BF4ACCCD6E1}']
end;
Type
  THuella = Class (TInterfacedObject,IHuella)
  Private
    FTipoHuella: String;
    FHuellaAnterior: string; //huella nueva, la actual
    FDatosRegistroAlta: TDatosRegistroAlta;
    FDatosRegistroAnulacion: TDatosRegistroAnulacion;
    FDatosEventos:TDatosEventos;
    FSignature: String;
  Public
    Property TipoHuella: String read FTipoHuella write FTipoHuella;
    Property HuellaAnterior: string read FHuellaAnterior write FHuellaAnterior;
    Procedure FirmarXML(const NombreArchivo: string);
    Class Function HuellaRegistroAlta(ADatosRegistroAlta:TDatosRegistroAlta;APrimerRegistro:char):string;
    Class Function HuellaRegistroAnulacion(ADatosRegistroAnulacion:TDatosRegistroAnulacion;APrimerRegistro:char):string;
   // Function HuellaEventos(ADatosEventosn:TDatosEventos;APrimerRegistro:char):string;
  End;
implementation
const
  RUTAAUTOFIRMA = 'C:\ruta\a\AutoFirma.exe';
  COMANDOSFIRMA = ' -firma -i ';



              {***  Clase Huella Funciones ***}

              { Huella Registro Anulacion }
Class Function THUella.HuellaRegistroAnulacion(ADatosRegistroAnulacion: TDatosRegistroAnulacion; APrimerRegistro: Char): string;
var
  valorstring: string;
  DateTimeStr: string;
  TimeZoneStr: string;
Begin
   valorString:='';
End;


             { Huella Registro Alta }
class Function THuella.HuellaRegistroAlta(ADatosRegistroalta: TDatosRegistroAlta; APrimerRegistro: Char): string;
var
  valorstring: string;
  DateTimeStr: string;
  TimeZoneStr: string;
begin
  valorstring := '';

  ADatosRegistroalta := TDatosRegistroalta.Create;
    // el nodo es RegistroAlta : Alta nueva o rectificada
    // concatenar campo y valores
    valorstring := 'IDEmisorFactura=' + ADatosRegistroalta.IDEmisorFactura + '&';
    valorstring := valorstring + 'NumSerieFactura=' + ADatosRegistroalta.NumSerieFactura + '&';
    valorstring := valorstring + 'FechaExpedicionFactura=' + FormatDateTime('dd-mm-yyyy', ADatosRegistroalta.FechaExpedicionFactura) + '&';
    valorstring := valorstring + 'TipoFactura=' + ADatosRegistroalta.TipoFactura + '&';
    valorstring := valorstring + 'CuotaTotal=' + FloatToStr(ADatosRegistroalta.CuotaTotal) + '&';
    valorstring := valorstring + 'ImporteTotal=' + FloatToStr(ADatosRegistroalta.ImporteTotal) + '&';
    if APrimerRegistro = 'N' then
          valorstring := valorstring + 'Huella=' + ADatosRegistroalta.Huella + '&';
    // Formatear FechaHoraHusoGenRegistro con zona horaria
    DateTimeStr := FormatDateTime('dd-mm-yyyy hh:nn:ss', ADatosRegistroalta.FechaHoraHusoGenRegistro);
    TimeZoneStr := FormatDateTime('T', ADatosRegistroalta.FechaHoraHusoGenRegistro, TFormatSettings.Create('es-ES'));
    valorstring := valorstring + 'FechaHoraHusoGenRegistro=' + DateTimeStr + ' ' + TimeZoneStr;
    ADatosRegistroalta.Free;
    Result := sha256(valorstring);
end;

procedure THuella.FirmarXML(const NombreArchivo: string);
var
  Comando: string;
begin
  Comando := RUTAAUTOFIRMA + COMANDOSFIRMA + NombreArchivo;
  ShellExecute(0, 'open', PChar(Comando), nil, nil, SW_SHOWNORMAL);
end;
end.

