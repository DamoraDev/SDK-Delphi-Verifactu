unit clase_IDFactura;
//DaMoRaDEV, SDK VeriFactu 0.2.0
interface
uses
  Classes, System.SysUtils, Unidad_Logica;
  Type IIDFactura = Interface
   ['{D4104341-D236-4E09-AF19-7D5D0942FFE9}']
  End;

type
  TIDFactura = class (TInterfacedObject , IIDFactura)
  private
    FIDEmisorFactura: string; // 9 NIFF
    FNumSerieFactura: string; // 60 alfanumerico
    FFechaExpedicionFactura: TDate; // Fecha dd-mm-yyyy
  public
    property IDEmisorFactura: string read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFactura: string read FNumSerieFactura write FNumSerieFactura;
    property FechaExpedicionFactura: TDate read FFechaExpedicionFactura write FFechaExpedicionFactura;
    constructor Create(NIF: string; NSerie: string);
    destructor Destroy; override;
    procedure Free;
  end;
implementation
{ TIDFactura }
constructor TIDFactura.Create(NIF: string; NSerie: string);
begin
  IDEmisorFactura := NIF;
  NumSerieFactura := NSerie;
  if NumSerieFactura.Length > 60 then
    raise Exception.Create('Error en Clase IDFactura : Número Serie Factura debe ser menor de 60 caracteres');
  if not ValidarNIF(IDEmisorFactura) then
    raise Exception.Create('Error en Clase IDFactura : NIF no válido');
  FFechaExpedicionFactura := Now;
end;
destructor TIDFactura.Destroy;
begin
  inherited Destroy;
end;
procedure TIDFactura.Free;
begin
  if Self <> nil then
    Destroy;
end;

end.



