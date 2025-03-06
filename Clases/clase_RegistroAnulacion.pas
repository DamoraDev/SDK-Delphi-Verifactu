unit clase_RegistroAnulacion;

interface
 uses classes,sysutils,
      clase_IDFactura,
      unidad_listasv2,
      unidad_logicaFechas,
      clase_DatosRegistroAnulacion,
      clase_Huella,
      clase_Encadenamiento,
      clase_GeneradoPor;

Type
    IRegistroAnulacion = interface
      ['{72B5199E-5D7E-4E0B-A9E3-104ADE97A38B}']
    end;
    TRegistroAnulacion = Class(TInterfacedObject,IRegistroAnulacion)
       Private
          FIDVersion:string;
          FIDFactura:TIDFactura;
          FRefExterna:String;// Alfanumerico 60
          FSinRegistroPrevio:char; //Listas.L4
          FRechazoPrevio:char; //listas.L17
          FGeneradoPor:TGeneradoPor;
          FNodoNecesario:Boolean;
          FEncadenamiento:TEncadenamiento;
          FSistemaInformatico:string;
          FFechaHoraHusoGenRegistro:string;
          FNumRegistroAcuerdoFacturacion:string;
          FIdAcuerdoSistemaInformatico:string;
          FTipoHuella:string;
       Public
          Property IDVersion:string
              read FIDVersion
              write FIDVersion;
          Property IDFactura:TIDFactura
              read FIDFactura
              write FIDFactura;
          Property RefExterna:string
              read FRefExterna
              write FRefExterna;
          Property SinRegistroPrevio:char
              read FSinregistroPrevio
              write FSinRegistroPrevio;
          Property RechazoPrevio:char
              read FRechazoPrevio
              write FRechazoPrevio;
          Property GeneradoPor:TGeneradoPor
              read FGeneradoPor
              write FGeneradoPor;
          Property NodoNecesario:boolean
              read FNodoNecesario
              write FNodoNecesario;
          Property Encadenamiento:TEncadenamiento
              read FEncadenamiento
              write FEncadenamiento;
          Property SistemaInformatico:string
              read FSistemaInformatico
              write FSistemaInformatico;
          Property FechaHoraHusoGenRegistro:string
              read FFechaHoraHusoGenRegistro
              write FFechaHoraHusoGenRegistro;
          Property  NumRegistroAcuerdoFacturacion:string
              read FNumRegistroAcuerdoFacturacion
              write FNumRegistroAcuerdoFacturacion;
          Property IdAcuerdoSistemaInformatico:string
              read FIdAcuerdoSistemaInformatico
              write FIdAcuerdoSistemaInformatico;
          Property TipoHuella:string
              read FTipoHuella
              write FTipoHuella;
          Constructor Create(AIDFactura:TIDFactura;
                            AGeneradoPor:TGeneradoPor;
                            AEncadenamiento:TEncadenamiento;
                            ANodoNecesario:boolean);Overload;
          constructor Create(ANodoNecesario:boolean);Overload;
          Destructor Destroy;Override;
          Procedure Free;
          Function GenerarHuella(IDFactura:TIDfactura;Encadenamiento:TEncadenamiento):string;

    End;

implementation

                   { Generación de la huella }

Function TRegistroAnulacion.GenerarHuella(IDFactura: TIDFactura; Encadenamiento: TEncadenamiento): string;
var  DatosRegistroAnulacion:TDatosRegistroAnulacion;
Begin

End;

                      { Constructores y Destructores }

  Procedure TRegistroAnulacion.Free;
  Begin
    try
        Destroy
    Except on E:Exception
        do raise Exception.Create('Error Procedimiento TRegistroAnulacion.Free '+E.Message);
    end;
  End;

  Destructor TRegistroAnulacion.Destroy;
  Begin
    try
    if  assigned(FIDFactura) then
            FreeAndNil(FIDFactura);
    if assigned(FGeneradoPor) then
            FreeAndNil(FGeneradoPor);
    Except on E:exception do
          raise Exception.Create('Error Destructor RegistroAnulacion :'+E.Message);
    end;
    inherited Destroy;
  End;

  constructor TRegistroAnulacion.Create(ANodoNecesario: Boolean);
  Begin
    if ANodoNecesario= true then
         raise Exception.Create('Error Constructor Clase RegistroAnulacion, si el nodo es necesario debe indicar IDFactura,GeneradoPor y Encadenamiento');
    FNodoNecesario := AnodoNecesario;
  End;
  Constructor TRegistroAnulacion.Create(AIDFactura: TIDFactura; AGeneradoPor: TGeneradoPor; AEncadenamiento: TEncadenamiento; ANodoNecesario: Boolean);
  begin
     inherited Create;
     if ANodoNecesario=False then
          raise Exception.Create('Error Constructor Clase RegistroAnulacion, si el nodo NO es necesario NO debe indicar IDFactura,GeneradoPor y Encadenamiento');
     IDVersion:='1.0';
     try
       FIDFactura:=AIDFactura;
       FGeneradoPor:=AGeneradoPor;
       FSinRegistroPrevio :=TL4.NO;
       FRechazoPrevio := TL17.Sin_RechazoPrevio_AEAT;
       FEncadenamiento := AEncadenamiento;
     Except on E:Exception
          do raise Exception.Create('Error Constructor Registroanulacion'+E.Message);
     end;
     FNodoNecesario:=ANodoNecesario ;
  End;

end.
