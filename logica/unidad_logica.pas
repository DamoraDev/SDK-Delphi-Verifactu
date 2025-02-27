unit unidad_logica;
//DaMoRaDEV, SDK VeriFactu 0.1.0
{
unit LogicaIVA;

interface
type
  TTipoIVA = (iva4, iva10, iva21);
  ConjuntoIVA = set of TTipoIVA;
function IVA: ConjuntoIVA;
implementation
function IVA: ConjuntoIVA;
begin
  Result := [iva4, iva10, iva21];
end;
end.

}
interface
  Uses classes,system.SysUtils;

  Function ValidarNIF(NIF: string): Boolean;

implementation

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
  // Extraer el n�mero y la letra de control
  Numero := Copy(NIF, 1, 8);
  DigitoControl := NIF[9];
  // Validar que los primeros 8 caracteres sean n�meros
  if not TryStrToInt(Numero, Resto) then Exit;
  // Calcular la letra de control
  Resto := StrToInt(Numero) mod 23;
  Result := DigitoControl = LetrasNIF[Resto + 1];
end;


end.
