unit unidad_logicaFechas;

interface

uses
  SysUtils, DateUtils, System.TimeSpan;

function ObtenerFechaConHusoHorario(AFecha: TDateTime): string;
function FormatoFechaString(Fecha: TDate): string;
function FormatoFechaDate(Fecha: string): TDate;

implementation

Function FormatoFechaDate(Fecha: string): TDate;
var
  FormatSettings: TFormatSettings;
Begin
  // Configurar un formato de fecha consistente
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'dd-mm-yyyy';

  // Convertir la cadena a fecha usando los FormatSettings
  Result := StrToDate(Fecha, FormatSettings);
End;

function FormatoFechaString(Fecha: TDate): string;
var
  FormatSettings: TFormatSettings;
begin
  // Configurar un formato de fecha consistente
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'dd-mm-yyyy';

  // Formatear la fecha usando las configuraciones definidas
  Result := FormatDateTime('dd-mm-yyyy', Fecha, FormatSettings);
end;

function ObtenerFechaConHusoHorario(AFecha: TDateTime): string;
var
  DateTimeStr: string;
  Offset: TTimeSpan;
  OffsetStr: string;
begin
  // Formatear la fecha y hora
  DateTimeStr := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', AFecha);

  // Obtener el offset en relación con UTC
  Offset := TTimeZone.Local.UtcOffset;

  // Crear el string del offset (horas y minutos)
  OffsetStr := Format('%.2d:%.2d', [Abs(Offset.Hours), Abs(Offset.Minutes)]);

  // Añadir el signo (+ o -)
  if Offset.TotalHours >= 0 then
    OffsetStr := '+' + OffsetStr
  else
    OffsetStr := '-' + OffsetStr;

  // Concatenar la fecha, hora y zona horaria
  Result := DateTimeStr + OffsetStr;
end;
 {
     var
      FechaFormateada: string;
    begin
      FechaFormateada := ObtenerFechaConHusoHorario(Now);
      WriteLn('Fecha con huso horario: ' + FechaFormateada);
    end;

 }
end.

