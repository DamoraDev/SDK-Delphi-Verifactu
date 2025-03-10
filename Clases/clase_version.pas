unit clase_version;

interface
uses classes, sysutils;

type IVersion = interface
  ['{1CF1766A-E938-4B1D-B221-FF27932AFC60}']
end;
type
  TVersion = class (TInterfacedObject, IVersion)
  public
    class function NumeroVersion: string;
    class function TipoVersion: string;  // "Alpha", "Beta","RC", "Final"
    class function FechaVersion: string; // Fecha de la versi�n
  end;



implementation

class function TVersion.NumeroVersion: string;
begin
  Result := '0.1.130';
end;
class function TVersion.TipoVersion: string;
begin
  Result := 'Alpha';
end;
class function TVersion.FechaVersion: string;
begin
  Result := '06-03-2025'; // Fecha de la versi�n
end;

end.
