unit clase_encadenamiento;

interface
uses sysutils,classes,unidad_logica;
type IEncadenamiento = interface
  ['{87C145B4-6FC3-47BA-8111-AADA6E344607}']
end;
type TEncadenamiento = Class(TInterfacedObject,IEncadenamiento)
    Private
      FPrimerRegistro:char; //S o N
      FRegistroAnterior_IDEmisorFactura:string; // alfanumerico 9 tipo NIF
      FRegistroAnterior_NumSerieFactura:string;// alfanumerico 60
      FRegistroAnterior_FechaExpedicionFactura:TDate; // fecha dd-mm-yyyy
      FRegistroAnterior_Huella:string;// alfanumerico 64
      FHayRegistroAnterior:boolean;
      Property SETHayRegistroAnterior:boolean write FHayRegistroAnterior;
    public
      Property PrimerRegistro:char read FPrimerRegistro write FPrimerRegistro;
      Property RegistroAnterior_IDEmisorFactura:string read FRegistroAnterior_IDEmisorFactura write FRegistroAnterior_IDEmisorFactura;
      Property RegistroAnterior_NumSerieFactura:string read FRegistroAnterior_NumSerieFactura write FRegistroAnterior_NumSerieFactura;
      Property RegistroAnterior_FechaExpedicionFactura:TDate read FRegistroAnterior_FechaExpedicionFactura write FRegistroAnterior_FechaExpedicionFactura;
      Property RegistroAnterior_Huella:string read FRegistroAnterior_Huella write FRegistroAnterior_Huella;
      Property GETHayRegistroAnterior:boolean read FHayRegistroAnterior;
      Constructor Create(APrimerRegistro:char);Overload;
      Constructor Create(APrimerRegistro:char;IDEmisor:string;NumSerie:string;Fecha:TDate;Huella:string);Overload;
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

                                   {  constructores sobrecargados }


Constructor TEncadenamiento.Create(APrimerRegistro:char;IDEmisor:string;NumSerie:string;Fecha:TDate;Huella:string);
Begin
   if (APrimerRegistro<>'N')OR(APrimerRegistro<>'S') then
        raise Exception.Create('Error: PRimerRegistro debe ser N o S');
   if (APrimerRegistro='S')then
        raise Exception.Create('Error:PrimerRegistro debe ser N si no hay registro anterior y no hay que indicar nigun otro dato. ');
   PrimerRegistro:=APrimerregistro;
   if PrimerRegistro='N' then  // hay registro anterior
          begin
             if not ValidarNIF(IDEmisor) then
                 raise Exception.Create('NIF no válido');
            if Numserie.Length>60 then
                 raise Exception.Create('Error: NumSerie debe ser menor o igual a 60 caracteres.');
            RegistroAnterior_IDEmisorFactura:=IDEmisor;
            RegistroAnterior_NumSerieFactura:=NumSerie;
            FormatDateTime('dd-mm-yyyy', Fecha);
            RegistroAnterior_FechaExpedicionFactura:=Fecha;
            RegistroAnterior_Huella:=Huella;
            SETHayRegistroAnterior:=true;
          end
End;
Constructor TEncadenamiento.Create(APrimerRegistro:char);
Begin
   if (APrimerRegistro<>'N')OR(APrimerRegistro<>'S') then
        raise Exception.Create('Error: PRimerRegistro debe ser N o S');
   if (APrimerRegistro='N')then
        raise Exception.Create('Error:PrimerRegistro debe ser S o indicar IDEmisor, NumSerie y Fecha del registro anterior');
   PrimerRegistro:=APrimerregistro;
   if PrimerRegistro ='S' then
          begin
            SETHayRegistroAnterior:=false; //para usar si no hay registro anterior y omitir estos datos
          end;
End;
end.
