unit clase_DatosEmpresa;
//DaMoRaDEV, SDK VeriFactu 0.1.0
interface
Uses classes, sysutils,unidad_logica;

type TDatosEmpresa = Class
     Private
       FNombreRazon:String; //120 string
       FNIF:string; //9 string
       FIDOtro_CodigoPais:string; //2 string  ISO 3166-1 alpha-2 codes
       FIDOtro_IDType:string; // 2 string
       FIDOtro_ID:string; //20 string;
       FNodo:string;
     Public
       Property NombreRazon:string read FNombreRazon write FNombreRazon;
       Property NIF: string read FNIF write FNIF;
       Property IDOtro_CodigoPais:string read FIDOtro_CodigoPais write FIDOtro_CodigoPais;
       Property IDOtro_IDType:string read FIDOtro_IDType write FIDOtro_IDType;
       Property IDOtro_ID:string read FIDOtro_ID write FIDOtro_ID;
       Property Nodo:string read FNodo write FNodo;
       Constructor Create(ANodo:string;ANIF:string;ANombreRazon:string);
       Destructor Destroy;Override;
       Procedure Free;
End;

implementation

{ Constructores y destructores }

  Procedure TDatosEmpresa.Free;
  Begin
    if self<>nil then destroy;
  End;

  Destructor TDatosEmpresa.Destroy;
  Begin
     Inherited Destroy;
  End;

  Constructor TDatosEmpresa.Create(ANodo: string; ANIF: string; ANombreRazon: string);
  Begin
     Nodo:=Anodo;
     if ANombreRazon.Length>120 then
          raise Exception.Create('NombreRazon no puede ser mayor que 120 caracteres');
     if not ValidarNIF(ANIF) then
      raise Exception.Create('NIF no válido');
     {se pueden comprobar el resto de datos en futuras versiones }
     NombreRazon:=ANombreRazon;
     NIF:=ANIF;
  End;
end.
