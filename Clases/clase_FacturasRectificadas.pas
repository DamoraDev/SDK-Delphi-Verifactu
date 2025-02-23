unit clase_FacturasRectificadas;
//DaMoRaDEV, SDK VeriFactu 0.1.0
//Revisado con Copilot de Microsoft
{
    <FacturasRectificadas>
       <IDFacturaRectificada>
          <IDEmisorFactura formato="FormatoNIF" longitud="9">123456789</IDEmisorFactura>
          <NumSerieFactura formato="Alfanumérico" longitud="60">Nº Serie+Nº Factura que identifica a la factura </NumSerieFactura>
          <FechaExpedicionFactura formato="dd-mm-yyyy">01-01-2025</FechaExpedicionFactura>
       </IDFacturaRectificada>
    </FacturasRectificadas>
}
interface
uses
  Classes, SysUtils, vcl.Dialogs,
  Unidad_Logica;

Type IFacturasRectificadas = interface
  ['{A5174F5F-A21E-40E1-95D0-E6A8F6B7513E}']
end;

type TFacturasRectificadas = class(TInterfacedObject,IFacturasRectificadas)
  private
    FIDEmisorFactura: string;
    FNumSerieFactura: string;
    FFechaExpedicionFactura: TDate;
    FFacturas: array of TFacturasRectificadas;
    FNodoNecesario:boolean;
  public
    property IDEmisorFactura: string read FIDEmisorFactura write FIDEmisorFactura;
    property NumSerieFactura: string read FNumSerieFactura write FNumSerieFactura;
    property FechaExpedicionFactura: TDate read FFechaExpedicionFactura write FFechaExpedicionFactura;
    Property NodoNecesario :boolean read FNodoNecesario write FNodoNecesario;
    constructor Create(ANodoNecesario:boolean;NIF: string; NumSerie: string; Fecha: TDate);Overload;
    constructor Create(ANodoNecesario:boolean);Overload;
    destructor Destroy; override;
    procedure Free;
  end;
implementation
{ TFacturasRectificadas }
constructor TFacturasRectificadas.Create(ANodoNecesario:boolean);
Begin
   if ANodoNecesario = true then raise Exception.Create('Error: Debe indicar NIF,NumSerie y  Fecha si el nodo es necesario');
   FNodoNecesario := ANodoNecesario;
   FIDEmisorFactura:='123456789Z';
   FNumSerieFactura:='0';
   FormatDateTime('dd-mm-yyyy',now);
   FFechaExpedicionFactura:=now;
End;
constructor TFacturasRectificadas.Create(ANodoNecesario:boolean;NIF: string; NumSerie: string; Fecha: TDate);
begin
  if ANodoNecesario = true then
      Begin
        if not ValidarNIF(NIF) then
          raise Exception.Create('Error: NIF no válido');
        if NumSerie.Length > 60 then
          raise Exception.Create('Error: Número de serie contiene más de 60 caracteres.');
        IDEmisorFactura := NIF;
        NumSerieFactura := NumSerie;
        FechaExpedicionFactura := Fecha;
        NodoNecesario:=ANodoNecesario;
      End else
  raise Exception.Create('Error: Si el nodo no es necesario no debe indicar NIF, NumSerie ni Fecha');
end;

destructor TFacturasRectificadas.Destroy;
begin
  inherited Destroy;
end;
procedure TFacturasRectificadas.Free;
begin
  if Self <> nil then
    Destroy;
end;


end.

