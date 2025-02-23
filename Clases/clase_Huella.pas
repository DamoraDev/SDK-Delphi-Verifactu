unit clase_Huella;
 //DaMoRaDEV, SDK VeriFactu 0.1.0
interface
Uses SysUtils, Classes, Xml.XMLDoc, Xml.XMLIntf, shellapi, windows;
Type
  TSeccion = (nRegistroAlta, nRegistroAnulacion);
  SetMinodo = Set of TSeccion;

type IDatosHuella = Interface
  ['{BBAB3174-8EB9-469D-BB5A-90536389B7AA}']
End;

Type
  TDatosHuella = Class(TInterfacedObject,IDatosHuella)
  Private
    FNodo: SetMinodo; // El tipo SetMinodo contiene valores de tipo TSeccion
    FIDEmisorFactura: string;
    FNumSerieFactura: string;
    FFechaExpedicionFactura: TDate;
    FTipoFactura: string;
    FCuotaTotal: Currency;
    FImporteTotal: Currency;
    FHuella: string;
    FFechaHoraHusoGenRegistro: TDateTime;
    Property Nodo: SetMinodo read FNodo write FNodo ;
  Public
    Property IDEmisorFactura: string read FIDEmisorFactura write FIDEmisorFactura;
    Property NumSerieFactura: string read FNumSerieFactura write FNumSerieFactura;
    Property FechaExpedicionFactura: TDate read FFechaExpedicionFactura write FFechaExpedicionFactura;
    Property TipoFactura: string read FTipoFactura write FTipoFactura;
    Property CuotaTotal: Currency read FCuotaTotal write FCuotaTotal;
    Property ImporteTotal: Currency read FImporteTotal write FImporteTotal;
    Property Huella: string read FHuella write FHuella; //huella anterior si existe
    Property FechaHoraHusoGenRegistro:TDateTime read FFechaHoraHusoGenRegistro write FFechaHoraHusoGenRegistro;
    Constructor Create(Anodo: TSeccion);
    Destructor Destroy;Override;
    Procedure Free;
  End;
type IHuella = interface
  ['{03702320-414D-4278-9DC6-8BF4ACCCD6E1}']
end;
Type
  THuella = Class (TInterfacedObject,IHuella)
  Private
    FTipoHuella: String;
    FHuella: string; //huella nueva, la actual
    FDatosHuella: TDatosHuella;
    FSignature: String;
    FNodo: SetMinodo;
    Property Nodo: SetMinodo read FNodo write FNodo ;
  Public
    Property TipoHuella: String read FTipoHuella write FTipoHuella;
    Property Huella: string read FHuella write FHuella;
    Procedure FirmarDocumentoXML(const NombreArchivo: string);
    Function NuevaHuella(Anodo:Tseccion;DatosHuella:TDatosHuella):string;
  End;
implementation
const
  RUTAAUTOFIRMA = 'C:\ruta\a\AutoFirma.exe';
  COMANDOSFIRMA = ' -firma -i ';

{ Clase DatosHuella Constructores y Destructores }

Procedure TDatosHuella.Free;
Begin
  if self<>nil then Destroy;
End;
Destructor TDatosHuella.Destroy;
Begin
  Inherited Destroy;
End;
Constructor TDatosHuella.Create(Anodo: TSeccion);
begin
  // Verificar si el valor de Anodo es válido dentro del conjunto GPT4
  if Anodo in [nRegistroAlta, nRegistroAnulacion] then
    FNodo := [Anodo]
  else
    raise Exception.Create('Error: el valor debe ser nRegistroAlta o nRegistroAnulacion');
  IDEmisorFactura:='';
  NumSerieFactura :='';
  FechaExpedicionFactura := StrToDate( FormatDateTime('dd-mm-yyyy',now));
  TipoFactura:='L2';
  CuotaTotal:=0.00;
  ImporteTotal:=0.00;
  Huella:='';
end;

{ Clase Huella Funciones }

Function THuella.NuevaHuella(Anodo: TSeccion; DatosHuella: TDatosHuella): string;
var
  valorstring: string;
  DateTimeStr: string;
  TimeZoneStr: string;
begin
  valorstring := '';
  if Anodo in [nRegistroAlta, nRegistroAnulacion] then
    FNodo := [Anodo]
  else
    raise Exception.Create('Error: el valor debe ser nRegistroAlta o nRegistroAnulacion');
  DatosHuella := TDatosHuella.Create(Anodo);
  if FNodo = [nRegistroAlta] then
  begin
    // el nodo es RegistroAlta : Alta nueva o rectificada
    // concatenar campo y valores
    valorstring := 'IDEmisorFactura=' + DatosHuella.IDEmisorFactura + '&';
    valorstring := valorstring + 'NumSerieFactura=' + DatosHuella.NumSerieFactura + '&';
    valorstring := valorstring + 'FechaExpedicionFactura=' + FormatDateTime('dd-mm-yyyy', DatosHuella.FechaExpedicionFactura) + '&';
    valorstring := valorstring + 'TipoFactura=' + DatosHuella.TipoFactura + '&';
    valorstring := valorstring + 'CuotaTotal=' + FloatToStr(DatosHuella.CuotaTotal) + '&';
    valorstring := valorstring + 'ImporteTotal=' + FloatToStr(DatosHuella.ImporteTotal) + '&';
    {
      if EsPrimeraFactura then
      valorstring := valorstring + 'Huella=0&'
    else
      valorstring := valorstring + 'Huella=' + DatosHuella.Huella + '&';
    }
    valorstring := valorstring + 'Huella=' + DatosHuella.Huella + '&';
    // Formatear FechaHoraHusoGenRegistro con zona horaria
    DateTimeStr := FormatDateTime('dd-mm-yyyy hh:nn:ss', DatosHuella.FechaHoraHusoGenRegistro);
    TimeZoneStr := FormatDateTime('T', DatosHuella.FechaHoraHusoGenRegistro, TFormatSettings.Create('es-ES'));
    valorstring := valorstring + 'FechaHoraHusoGenRegistro=' + DateTimeStr + ' ' + TimeZoneStr;
  end
  else if FNodo = [nRegistroAnulacion] then
  begin
    // el nodo es RegistroAnulacion : factura anulada
  end;
  DatosHuella.Free;
  Result := valorstring;
end;

procedure THuella.FirmarDocumentoXML(const NombreArchivo: string);
var
  Comando: string;
begin
  Comando := RUTAAUTOFIRMA + COMANDOSFIRMA + NombreArchivo;
  ShellExecute(0, 'open', PChar(Comando), nil, nil, SW_SHOWNORMAL);
end;
end.

