unit unidad_logicaFechas;

interface

uses
  SysUtils, DateUtils, System.TimeSpan;

function ObtenerFechaConHusoHorario(AFecha: TDateTime): string;
function FormatoFechaString(Fecha: TDate): string;
function FormatoFechaDate(Fecha: string): TDate;
function CadenaHusoHorarioAFecha(const ISO8601: string): TDateTime;

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


function CadenaHusoHorarioAFecha(const ISO8601: string): TDateTime;
var
  FechaStr, HoraStr, ZonaHoraria: string;
  Año, Mes, Día, Hora, Minuto, Segundo: Word;
  HorasOffset, MinutosOffset: Integer;
  Signo: Integer;
begin
  // Separar partes: fecha, hora y zona horaria
  FechaStr := Copy(ISO8601, 1, 10);
  HoraStr := Copy(ISO8601, 12, 8);
  ZonaHoraria := Copy(ISO8601, 20, 6);

  // Obtener fecha (Año-Mes-Día)
  Año := StrToInt(Copy(FechaStr, 1, 4));
  Mes := StrToInt(Copy(FechaStr, 6, 2));
  Día := StrToInt(Copy(FechaStr, 9, 2));

  // Obtener hora (Hora:Minuto:Segundo)
  Hora := StrToInt(Copy(HoraStr, 1, 2));
  Minuto := StrToInt(Copy(HoraStr, 4, 2));
  Segundo := StrToInt(Copy(HoraStr, 7, 2));

  // Construir el TDateTime base
  Result := EncodeDateTime(Año, Mes, Día, Hora, Minuto, Segundo, 0);

  // Procesar zona horaria
  if Length(ZonaHoraria) = 6 then
  begin
    // Determinar el signo (+ o -)
    if ZonaHoraria[1] = '+' then
      Signo := -1 // Restar el offset para obtener UTC
    else if ZonaHoraria[1] = '-' then
      Signo := 1  // Sumar el offset para obtener UTC
    else
      raise Exception.Create('Formato de zona horaria inválido.');

    // Obtener horas y minutos del offset
    HorasOffset := StrToInt(Copy(ZonaHoraria, 2, 2));
    MinutosOffset := StrToInt(Copy(ZonaHoraria, 5, 2));

    // Aplicar el offset a la fecha y hora base
    Result := IncHour(Result, Signo * HorasOffset);
    Result := IncMinute(Result, Signo * MinutosOffset);
  end;
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

