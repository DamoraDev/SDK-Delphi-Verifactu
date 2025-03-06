unit clase_Tercero;

interface

uses classes,sysutils, unidad_logica;
type ITercero = interface
  ['{FD567717-9F96-42C5-870D-15AEF08EF19A}']
end;

type TTercero = Class(TInterfacedObject,ITercero)
     Private
       FNombreRazon:String; //alfanumerico 120
       FNIF:string;      // alfanumerico 9 :12345678Z
       FIDOtro_CodigoPais:string;//alfanumerico  2
       FIDOtro_IDType:string;  //alfanumerico 2
       FIDOtro_ID:string;     //alfanumerico 20
       FNodoNecesario:boolean;
     Public
     Property NombreRazon : string read FNombreRazon write FNombreRazon;
     Property NIF : string read FNIF write FNIF;
     Property IDOtro_CodigoPais:string read FIDOtro_CodigoPais write FIDOtro_CodigoPais;
     Property IDOtro_IDType:string read FIDOtro_IDType write FIDOtro_IDType;
     Property IDOtro_ID:string read FIDOtro_ID write FIDOtro_ID;
     Property NodoNecesario:boolean read FNodoNecesario write FNodoNecesario;
     Constructor Create(ANodoNecesario:boolean;NombreRazon:string;NIF:string);Overload;
     Constructor Create(ANodoNecesario:boolean);Overload;
     Destructor Destroy;Override;
     Procedure Free;
End;
implementation

{ Constructores y destructores }

Procedure TTercero.Free;
Begin
   if self<>nil then destroy;
End;

Destructor TTercero.Destroy;
Begin
  inherited destroy;
End;
Constructor TTercero.Create(ANodoNecesario: Boolean);
Begin
  if ANodoNecesario = true  then  raise Exception.Create('Error clase Tercero : Es necesario indicar Nombrerazon y NIF si el nodo es necesario');
  NodoNecesario := AnodoNecesario;
End;

Constructor TTercero.Create(ANodoNecesario:boolean;NombreRazon:string;NIF:string);
Begin
  if ANodoNecesario = False  then  raise Exception.Create('Error  clase Tercero : NO Es necesario indicar Nombrerazon y NIF si el nodo NO es necesario');
  if Length(NombreRazon) > 120 then
    raise Exception.Create('Error clase Tercero : NomberRazon  no debe superar los 120 caracteres.');
  if not ValidarNIF(NIF) then
    raise Exception.Create('Error clase Tercero: NIF no válido');
  NodoNecesario := False;
  IDOtro_CodigoPais:='ES';
  IDOtro_IDType:='';
  IDOtro_ID:='';
  NodoNecesario := AnodoNecesario;
End;

end.
