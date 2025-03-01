unit unidad_logica;
//DaMoRaDEV, SDK VeriFactu 0.1.0

interface
  Uses classes,system.SysUtils,HASH;

  Function ValidarNIF(NIF: string): Boolean;
  Function SHA256(texto:string):string;

implementation

{ sha 256 }
 Function SHA256(texto:string):string;
  var
    SHA256: THashSHA2;
  begin
    try
        SHA256 := THashSHA2.Create;
    finally
        Result := SHA256.GetHashString(texto);
    end;
  end;
{  Validar NIF }
function ValidarNIF(NIF: string): Boolean;
const
  LetrasNIF: string = 'TRWAGMYFPDXBNJZSQVHLCKE';
var
  Numero: string;
  DigitoControl: Char;
  Resto: Integer;
begin
  Result := False;
  if Length(NIF) <> 9 then Exit;
  // Extraer el número y la letra de control
  Numero := Copy(NIF, 1, 8);
  DigitoControl := NIF[9];
  // Validar que los primeros 8 caracteres sean números
  if not TryStrToInt(Numero, Resto) then Exit;
  // Calcular la letra de control
  Resto := StrToInt(Numero) mod 23;
  Result := DigitoControl = LetrasNIF[Resto + 1];
end;


end.
