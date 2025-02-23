unit clase_Destinatarios;

interface
uses Classes, sysutils, unidad_logica;
type IDestinatarios = Interface
  ['{4ABAC361-5153-4DC1-8490-DA1AB0530933}']
End;
Type TDestinatarios = Class (TInterfacedObject,IDestinatarios)
   Private
     FCantidadDestinatarios:integer;
     FNombreRazon:string;// alfanumerico 120
     FNIF:string;// alfanumerico 9 NIF
     FIDOtro_CodigoPais:string;//alfanumerico  2
     FIDOtro_IDType:string;  //alfanumerico 2
     FIDOtro_ID:string;     //alfanumerico 20
     FNodoNecesario:Boolean; //indicar si hay destinatarios o no. la factura simplificada F2 no lleva destinatarios
   public
     Property CantidadDestinatarios:integer read FCantidadDestinatarios write FCantidadDestinatarios;
     Property NombreRazon:string read FNombreRazon write FNombreRazon;
     property NIF:string read FNIF write FNIF;
     Property IDOtro_CodigoPais:string read FIDOtro_CodigoPais write FIDOtro_CodigoPais;
     Property IDOtro_IDType:string read FIDOtro_IDType write FIDOtro_IDType;
     Property IDOtro_ID:string read FIDOtro_ID write FIDOtro_ID;
     Property NodoNecesario : Boolean read FNodoNecesario write FNodoNecesario;
     Constructor Create(ANodoNecesario:boolean;ANombreRazon:string;ANIF:string;Cantidad:integer);Overload;
     Constructor Create(ANodoNecesario:boolean);Overload;
     Destructor Destroy;Override;
     Procedure Free;
End;
implementation

{ Constructores y destructores }
Procedure TDestinatarios.Free;
Begin
   if self<> nil then destroy;
End;
Destructor TDestinatarios.Destroy;
Begin
 inherited Destroy;
End;
Constructor TDestinatarios.Create(ANodoNecesario: Boolean);
Begin
  if ANodoNecesario = true  then raise Exception.Create('Error: Es necesario indicar NombreRazon y NIF si el nodo  es necesario.');
  NodoNecesario:=ANodoNecesario;
End;

Constructor TDestinatarios.Create(ANodoNecesario:boolean;ANombreRazon: string; ANIF: string;Cantidad:integer);
begin
  if ANodoNecesario = False  then raise Exception.Create('Error: No es necesario indicar NombreRazon ni NIF si el nodo no es necesario.');
  if not ValidarNIF(ANIF) then
      raise Exception.Create('NIF no válido');
  if ANombreRazon.Length>120 then
      raise Exception.Create('Error: NombreRazon No puede superar los 120 Caracteres');
  IDOtro_CodigoPais:='ES';
  IDOtro_IDType:='';
  IDOtro_ID:='';
  FCantidadDestinatarios := Cantidad; // verificar que este entre 1 y xxx
  NIF := Anif;
  NombreRazon := ANombreRazon;
  NodoNecesario:=AnodoNecesario;
end;

end.
