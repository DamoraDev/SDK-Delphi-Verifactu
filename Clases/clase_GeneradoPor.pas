unit clase_GeneradoPor;

interface
uses classes, sysutils,
      unidad_logica;

type  IGeneradoPor = Interface
         ['{AA13DA2C-C367-4B60-9B64-7E407479E7FB}']

      End;
      TGeneradoPor = Class(TInterfacedObject,IGeneradoPor)
        Private
          FGenerador_NombreRazon:string;//120
          FGenerador_NIF:string;// formato NIF;
          FIDOtro_CodigoPais:string;//2 ISO alpha 2
          FIDOtro_IDType:string;//Listas.L7
          FIDOtro_ID:string;//20
        public
         Property Generador_NombreRazon:String
                read FGenerador_NombreRazon
                write FGenerador_NombreRazon;
         Property Generador_NIF:string
                read FGenerador_NIF
                write FGenerador_NIF;
         Property IDOtro_CodigoPais:string
                read FIDOtro_CodigoPais
                write FIDOtro_CodigoPais;
         Property IDOtro_IDType:String
                read FIDOtro_IDtype
                write FIDOtro_IDtype;
         Property IDOtro_ID:String
                read FIDOtro_ID
                write FIDOtro_ID;
         Constructor Create(ANombreRazon:String;ANIF:string);
         Destructor Destroy;Override;
         Procedure Free;
      End;


implementation
  { Constructores y destructores }
  Procedure TGeneradoPor.Free;
  Begin
    if self<>nil then Destroy;
  End;

  Destructor TGeneradoPor.Destroy;
  Begin
    inherited Destroy;
  End;

  Constructor TGeneradoPor.Create(ANombreRazon: string; ANIF: string);
  Begin
      if not ValidarNIF(ANIF) then
          raise Exception.Create('Error en Clase GeneradoPor :NIF no válido.');
      if ANombreRazon.Length>120 then
          raise Exception.Create('Error en Clase GeneradoPor : NombreRazon con mas de 120 Caracteres.');
     Generador_NombreRazon:=ANombreRazon;
     Generador_NIF:=ANIF;
     IDOtro_CodigoPais:='ES';
     IDOtro_IDType:='';
     IDOtro_ID:='';
  End;
end.
