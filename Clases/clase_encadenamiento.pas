unit clase_encadenamiento;

interface
uses sysutils,classes;
type IEncadenamiento = interface
  ['{87C145B4-6FC3-47BA-8111-AADA6E344607}']
end;
type TEncadenamiento = Class(TInterfacedObject,IEncadenamiento)
    Private
      FPrimerRegistro:char; //S o N
      FHayRegistroAnterior:boolean;//si hay registroAnterior
      FRegistroAnterior_IDEmisorFactura:string; // alfanumerico 9 tipo NIF
      FRegistroAnterior_NumSerieFactura:string;// alfanumerico 60
      FRegistroAnterior_FechaExpedicionFactura:TDate; // fecha dd-mm-yyyy
      FRegistroAnterior_Huella:string;// alfanumerico 64
    public
      Property PrimerRegistro:char read FPrimerRegistro write FPrimerRegistro;
      property HayRegistroAnterior:boolean read FHayRegistroAnterior  write FHayRegistroAnterior;
      Property RegistroAnterior_IDEmisorFactura:string read FRegistroAnterior_IDEmisorFactura write FRegistroAnterior_IDEmisorFactura;
      Property RegistroAnterior_NumSerieFactura:string read FRegistroAnterior_NumSerieFactura write FRegistroAnterior_NumSerieFactura;
      Property RegistroAnterior_FechaExpedicionFactura:TDate read FRegistroAnterior_FechaExpedicionFactura write FRegistroAnterior_FechaExpedicionFactura;
      Property RegistroAnterior_Huella:string read FRegistroAnterior_Huella write FRegistroAnterior_Huella;
      Constructor Create;
      Destructor Destroy;Override;
      Procedure Free;
End;

implementation

        { Constructores y Destructores}

Procedure TEncadenamiento.Free;
Begin
  if self<>nil  then  destroy;
End;
Destructor TEncadenamiento.Destroy;
Begin
  inherited Destroy;
End;
Constructor TEncadenamiento.Create;
Begin
   FPrimerRegistro:='N';
End;
end.
