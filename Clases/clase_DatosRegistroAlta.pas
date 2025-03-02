unit clase_DatosRegistroAlta;

interface

Uses SysUtils, Classes, shellapi, windows,unidad_logica;
type IDatosRegistroAlta= Interface
  ['{BBAB3174-8EB9-469D-BB5A-90536389B7AA}']
End;

Type
  TDatosRegistroAlta = Class(TInterfacedObject,IDatosRegistroAlta)
  Private
    FIDEmisorFactura: string;
    FNumSerieFactura: string;
    FFechaExpedicionFactura: TDate;
    FTipoFactura: string;
    FCuotaTotal: Currency;
    FImporteTotal: Currency;
    FHuella: string;
    FFechaHoraHusoGenRegistro: TDateTime;
    FPrimerRegistro:char;
  Public
    Property IDEmisorFactura: string read FIDEmisorFactura write FIDEmisorFactura;
    Property NumSerieFactura: string read FNumSerieFactura write FNumSerieFactura;
    Property FechaExpedicionFactura: TDate read FFechaExpedicionFactura write FFechaExpedicionFactura;
    Property TipoFactura: string read FTipoFactura write FTipoFactura;
    Property CuotaTotal: Currency read FCuotaTotal write FCuotaTotal;
    Property ImporteTotal: Currency read FImporteTotal write FImporteTotal;
    Property Huella: string read FHuella write FHuella; //huella anterior si existe
    Property FechaHoraHusoGenRegistro:TDateTime read FFechaHoraHusoGenRegistro write FFechaHoraHusoGenRegistro;
    Property PrimerRegistro:char read  FPrimerRegistro write FPrimerRegistro;
    Constructor Create;
    Destructor Destroy;Override;
    Procedure Free;
  End;

implementation

           { *** Constructores y destructores ***}

Procedure TDatosRegistroAlta.Free;
Begin
  if self<>nil then Destroy;
End;
Destructor TDatosRegistroAlta.Destroy;
Begin
  Inherited Destroy;
End;
Constructor TDatosRegistroAlta.Create;
var
  FormatSettings: TFormatSettings;
begin
  IDEmisorFactura := '';
  NumSerieFactura := '';
  // Configurar FormatSettings para un formato específico de fecha
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'dd-mm-yyyy';

  // Usar FormatSettings para evitar problemas de formato
  FechaExpedicionFactura := StrToDate(FormatDateTime('dd-mm-yyyy', Now, FormatSettings), FormatSettings);

  TipoFactura := 'L2';
  CuotaTotal := 0.00;
  ImporteTotal := 0.00;
  Huella := '';
end;

end.
