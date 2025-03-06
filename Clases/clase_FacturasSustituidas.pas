unit clase_FacturasSustituidas;
//DaMoRaDEV, SDK VeriFactu 0.1.0
{         IDFacturaSustituida lleva contador 1 a 10000
<FacturasSustituidas>
			<IDFacturaSustituida (1-1000)>
					<IDEmisorFactura formato="FormatoNIF" longitud="9">123456789</IDEmisorFactura>
					<NumSerieFactura formato="Alfanumérico" longitud="60">Nº Serie+Nº Factura que identifica a la factura </NumSerieFactura>
					<FechaExpedicionFactura formato="dd-mm-yyyy">01-01-2025</FechaExpedicionFactura>
			</IDFacturaSustituida>
</FacturasSustituidas>
}
interface

uses  Classes, Sysutils,
      unidad_logica;
Type IFacturasSustituidas = Interface
   ['{7A1324BB-4FDB-4DDE-9A48-98E5ADF19B35}']
End;

Type TFacturasSustiuidas = class(TInterfacedObject,IFacturasSustituidas )
     Private
       FIDEmisorFactura:string;
       FNumSerieFactura:string;
       FFechaExpedicionFactura:Tdate;
       FNodoNecesario:boolean;
       FFacturas: Array of TFacturasSustiuidas;
       FCantidadFacturas:integer;
     public
       Property IDEmisorFactura:string read FIDEmisorFactura write FIDEmisorFactura;
       Property NumSerieFactura:string read FNumSerieFactura write FNumSerieFactura ;
       Property FechaExpedicionFactura:Tdate read FFechaExpedicionFactura write FFechaExpedicionFactura;
       Property NodoNecesario :boolean read FNodoNecesario write FNodoNecesario;
       Property CantidadFacturas:integer read FCantidadFacturas write FcantidadFacturas;
       Constructor Create(ACantidadFacturas:integer;ANodoNecesario:boolean;NIF:String;Numserie:string;Fecha:Tdate);Overload;
       Constructor Create(ANodoNecesario:boolean);Overload;
       Destructor Destroy;Override;
       Procedure Free;
end;

implementation

              {  Funciones y Procedimientos }


              { Constructores y Destructores }

Procedure TFacturasSustiuidas.Free;
Begin
   if self<>nil  then Destroy;
End;

Destructor TFacturasSustiuidas.Destroy;
Begin
  inherited Destroy;
End;
Constructor TFacturasSustiuidas.Create(ANodoNecesario: Boolean);
Begin
  if ANodoNecesario = True then  raise Exception.Create('Error en clase FacturasSustituidas : Nodo Necesario, se ha de indicar NIF,NumSerie y Fecha');
  NodoNecesario:=ANodoNecesario;
  IDEmisorFactura :='12345678Z';
  NumSerieFactura:='0';
  FormatDateTime('dd-mm-yyyy',now);
  FechaExpedicionFactura:=now;
End;
Constructor TFacturasSustiuidas.Create(ACantidadFacturas:integer;ANodoNecesario:boolean;NIF: string; Numserie: string; Fecha: TDate);
Begin
   if (ACantidadFacturas<=0)OR(ACantidadFacturas>1000) then raise Exception.Create('Error en clase FacturasSustituidas : Cantidad Facturas debe ser un valor entre 1 y 1000');
   if ANodoNecesario = true then
       Begin
         if not ValidarNIF(NIF) then
           raise Exception.Create('Error en clase FacturasSustituidas  : NIF no válido');
         if Numserie.Length>60 then raise Exception.Create('Error en clase FacturasSustituidas : Numero de serie contiene mas de 60 caracteres.');
         FormatDateTime('dd-mm-yyyy',Fecha);
         IDEmisorFactura := NIF;
         NumSerieFactura := Numserie;
         FechaExpedicionFactura :=Fecha;
         NodoNecesario:=ANodoNecesario;
       End else
   raise Exception.Create('Error en clase FacturasSustituidas : Si el Nodo no es necesario no es necesario indicar NIF, NumSerie ni Fecha');
   CantidadFacturas:=1;
End;
end.
