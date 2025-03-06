unit clase_RegistroAlta;
//DaMoRaDEV, SDK VeriFactu 0.2.0
interface
uses
  Classes, Sysutils,
  clase_IDFactura,vcl.Dialogs,
  clase_FacturasRectificadas,
  clase_FacturasSustituidas,
  clase_ImporteRectificacion,
  clase_Desglose,clase_Encadenamiento,
  clase_Tercero,clase_Destinatarios,
  clase_Huella, unidad_LogicaFechas,
  clase_DatosRegistroAlta,
  unidad_logica;
Type IRegistroAlta = Interface
     ['{0C849AFB-8F4C-4C01-9E18-B766C613A803}']
End;

type
  TFormatoFactura = (fF1, fF2, fF3, fR1, fR2, fR3, fR4, fR5); // rectificar, esto esta en la unidad_listas v2
 
  ConjuntoFacturas = Set of TFormatoFactura;
  TnodoIDFactura = (nRegistoAlta, nRegistroAnulacion);
  ConjuntoIDFactura = Set of TnodoIDFactura;

type TRegistroAlta = class(TInterfacedObject,IRegistroAlta)
  private
    FIDFactura: TIDFactura;
    FRefExterna: string; // string [60]
    FNombreRazonEmisor: string; // string [120]
    FSubsanacion: char; // S ó N
    FRechazoPrevio: char; // S ó N
    FTipoFactura: string; // string [2] formato L2
    FTipoRectificativa: char; // S ó N
    FFacturasRectificadas: TFacturasRectificadas;
    FFacturasSustituidas:TFacturasSustiuidas;
    FNodoIDFactura: TnodoIDFactura;
    FMiTipoFactura: ConjuntoFacturas;
    FIDVersion:string;
    FImporteRectificacion:TImporteRectificacion;
    // -- Nuevos, a falta de construir la property  16 2 2025---
    FFechaOperacion:TDate; // dd-mm-yyyy
    FDescripcionOperacion:string; //500
    FFacturaSimplificadaArt7273:Char; //S o N
    FFacturaSinIdentifDestinatarioArt61d:char;// S o N
    FMacrodato:char; // S o N
    FEmitidaPorTerceroDestinatario:char; // L6
    FTercero : TTercero;
    FRequiereTercero:boolean;
    FDestinatarios:TDestinatarios;
    FCupon:char;//120 L4  S/N
    FDesglose:TDesglose;
    FEncadenamiento:TEncadenamiento;
    FCuotaTotal:currency;
    FImporteTotal:currency;
    FNodoNecesario:boolean;
  public
    Procedure SETSubsanacion(Valor:char);
    Procedure SETRechazoPrevio(Valor:char);
    Function GETSubsanacion:char;
    Function GETRechazoPrevio:char;
    Property NodoNecesario:boolean  // para generar RegistroAlta o RegistroAnulacion segun Corresponda
            read FNodoNecesario
            write FNodoNecesario;
    property IDFactura: TIDFactura
            read FIDFactura
            write FIDFactura;
    property RefExterna: string
            read FRefExterna
            write FRefExterna;
    property NombreRazonEmisor: string
            read FNombreRazonEmisor
            write FNombreRazonEmisor;
    property Subsanacion: char
            read GETSubsanacion
            write SETSubsanacion;
    property RechazoPrevio: char
            read GETRechazoPrevio
            write SETRechazoPrevio;
    property TipoFactura: string
            read FTipoFactura
            write FTipoFactura;
    property TipoRectificativa: char
            read FTipoRectificativa
            write FTipoRectificativa;
    property FacturasRectificadas: TFacturasRectificadas
            read FFacturasRectificadas
            write FFacturasRectificadas;
    property FacturasSustituidas:TFacturasSustiuidas
            read FFacturasSustituidas
            write FFacturasSustituidas;
    Property NodoIDFactura: TnodoIDFactura
            read FNodoIDFactura
            write FNodoIDFactura;
    Property IDVersion : string
            read FIDVersion
            write FIDVersion;
    Property ImporteRectificacion : TImporteRectificacion
            read FImporteRectificacion
            write FImporteRectificacion;
   // nuevas properties  16 02 2025
    Property FechaOperacion : TDate
            read FFechaOperacion
            write FFechaOperacion;
    Property DescripcionOperacion : string
            read  FDescripcionOperacion
            write FDescripcionOperacion;
    Property FacturaSimplificadaArt7273:char
            read FFacturaSimplificadaArt7273
            write FFacturaSimplificadaArt7273;
    Property FacturaSinIdentifDestinatarioArt61d : char
            read FFacturaSinIdentifDestinatarioArt61d
            write FFacturaSinIdentifDestinatarioArt61d;
    Property Macrodato:char
            read FMacrodato
            write FMacrodato;
    Property EmitidaPorTerceroDestinatario:char
            read FEmitidaPorTerceroDestinatario
            write FEmitidaPorTerceroDestinatario;
    Property Tercero:TTercero
            read FTercero
            write FTercero;
    property Destinatarios:TDestinatarios
            read FDestinatarios
            write FDestinatarios;
    Property Cupon:char
            read FCupon
            write Fcupon;
    Property Desglose:TDesglose
            read FDesglose
            write FDesglose;
    Property Encadenamiento:TEncadenamiento
            read FEncadenamiento
            write FEncadenamiento;
    Property CuotaTotal:Currency
            read FCuotaTotal
            write FCuotaTotal;
    Property ImporteTotal:Currency
            read FImporteTotal
            write FImporteTotal;
   // constructor Create(AIDFactura: TIDFactura; RefExterna: string; TipoFactura: TFormatoFactura);
    constructor Create(ANombreRazonEMisor:string;
                       AIDFactura: TIDFactura;
                       RefExterna: string;
                       TipoFactura: TFormatoFactura;
                       AFacturasRectificadas: TFacturasRectificadas;
                       AFacturasSustituidas:TFacturasSustiuidas;
                       ATercero:TTercero;ADestinatarios:TDestinatarios;
                       AImporteRectificacion:TImporteRectificacion;
                       ADesglose:TDesglose;
                       AEncadenamiento:TEncadenamiento;
                       ANodoNecesario:boolean);Overload;
    Constructor create(ANodoNecesario:boolean);Overload;
    destructor Destroy;Override;
    Procedure Free;
    Function GenerarHuella(IDFactura:TIDfactura;Encadenamiento:TEncadenamiento):string;
  end;

var
  NombreNodo: string = ''; // nombre nodos para posicionar las subclases en el XML

implementation

                       {  Generar Huella }

 { La huella cambia en cada ocasion que se genera, no permanece constante }


Function TRegistroAlta.GenerarHuella(IDFactura:TIDfactura;Encadenamiento:TEncadenamiento):string;
var  DatosRegistroAlta:TDatosRegistroAlta;
Begin
  DatosRegistroAlta:= TDatosRegistroAlta.Create;
  DatosRegistroAlta.IDEmisorFactura:=IDFactura.IDEmisorFactura;
  DatosRegistroAlta.NumSerieFactura:=IDFactura.NumSerieFactura;
  DatosRegistroAlta.FechaExpedicionFactura:=IDFactura.FechaExpedicionFactura ;
 // DatosRegistroAlta.TipoFactura:=TipoFactura;
  DatosRegistroAlta.CuotaTotal := FCuotaTotal;
  DatosRegistroAlta.ImporteTotal := FImporteTotal;
  DatosRegistroAlta.PrimerRegistro:=Encadenamiento.PrimerRegistro;
  DatosRegistroAlta.Huella:=Encadenamiento.RegistroAnterior_Huella;
  // verificar la fecha   solucionar esta parte
  DatosRegistroAlta.FechaHoraHusoGenRegistro:=ObtenerFechaConHusoHorario(FFechaOperacion);
 // showmessage('Fecha Huso Horario'+ObtenerFechaConHusoHorario(FFechaOperacion));
  Result:=THuella.HuellaRegistroAlta(DatosRegistroalta);
  DatosRegistroAlta.Free;
End;


{ Getter y Setter Subsanacion y RechazoPrevio}


Function TRegistroAlta.GETRechazoPrevio: Char;
Begin
  result := FRechazoPrevio;
End;
Function TRegistroAlta.GETSubsanacion: Char;
begin
  result := FSubsanacion;
end;
Procedure TRegistroAlta.SETRechazoPrevio(Valor: Char);
Begin
  if (valor<>'N')AND(valor<>'S')AND(valor<>'X') then
     raise Exception.Create('Error en Clase RegistroAlta : RechazoPrevio debe ser N, S o X');
  if (valor='X')AND( GETSubsanacion='N') then
      raise Exception.Create('Error en Clase RegistroAlta : No se admiten Facturas con Subsanacion N y Rechazo Previo X')
  else FRechazoPrevio := valor;
End;

Procedure TRegistroAlta.SETSubsanacion(Valor: Char);
Begin
  if (Valor<>'N')AND (Valor<>'S') then
    raise Exception.Create('Error en Clase RegistroAlta : Subsanacion debe de ser S o N');
  if ( valor = 'N' )AND (GETRechazoPrevio='X')  then
    raise Exception.Create('Error en Clase RegistroAlta : No se admiten Facturas con Subsanacion N y Rechazo Previo X')
  else FSubsanacion := valor;
End;
{ Constructores y Destructores }


procedure TRegistroAlta.Free;
begin
  try
    Destroy;
  except
    on E: Exception do
      raise Exception.Create('Error en Clase RegistroAlta Procedimiento Free : ' + E.Message);
  end;
end;

destructor TRegistroAlta.Destroy;
begin
  try
    if Assigned(FIDFactura) then
      FreeAndNil(FIDFactura);
    if Assigned(FFacturasRectificadas) then
      FreeAndNil(FFacturasRectificadas);
    if Assigned(FFacturasSustituidas) then
      FreeAndNil(FFacturasSustituidas);
    if assigned (FTercero) then
      FreeAndNil(Ftercero);
    if assigned (FDestinatarios) then
      FreeAndNil(FDestinatarios);
    if assigned (FImporteRectificacion) then
      FreeAndNil(FImporteRectificacion);
    if assigned (FDesglose) then
      FreeAndNil (FDesglose);
    if assigned (FEncadenamiento) then
      FreeAndNil (FEncadenamiento);
  except
    on E: Exception do
      raise Exception.Create('Error en Destructor clase RegistroAlta: ' + E.Message);
  end;
  inherited Destroy;
end;

constructor TRegistroAlta.create(ANodoNecesario: Boolean);
begin
  if ANodoNecesario = true then
      raise Exception.Create('Error Constructor clase RegistroAlta, si el nodo es necesario debe indicar los demas datos');
end;

constructor TRegistroAlta.Create( ANombreRazonEMisor: string;
                                  AIDFactura: TIDFactura; RefExterna: string;
                                  TipoFactura: TFormatoFactura;
                                  AFacturasRectificadas: TFacturasRectificadas;
                                  AFacturasSustituidas: TFacturasSustiuidas;
                                  ATercero: TTercero; ADestinatarios: TDestinatarios;
                                  AImporteRectificacion: TImporteRectificacion;
                                  ADesglose: TDesglose; AEncadenamiento: TEncadenamiento;
                                  ANodoNecesario: Boolean);
begin
  inherited Create;
  if ANodoNecesario = False then
        raise Exception.Create('Error Constructor RegistroAlta, si el nodo no es necesario, no debe indicar mas datos.');
  FIDversion:='1.0';
  // Asignamos las instancias pasadas al constructor
  FIDFactura := AIDFactura;
  FFacturasRectificadas := AFacturasRectificadas;
  FFacturasSustituidas := AFacturasSustituidas;
  FTercero := ATercero;
  FDestinatarios:=ADestinatarios;
  FImporteRectificacion:=AImporteRectificacion;
  FDesglose:=ADesglose;
  FEncadenamiento:=AEncadenamiento;
  // Validamos la longitud de RefExterna
  if Length(RefExterna) > 60 then
    raise Exception.Create('Error: Referencia Externa no debe superar los 60 caracteres.');
  // Validamos el TipoFactura
  if TipoFactura in [fF1, fF2, fF3, fR1, fR2, fR3, fR4, fR5] then
    FMiTipoFactura := [TipoFactura]
  else
    raise Exception.Create('Error: El tipo de factura debe ser fF1, fF2, fF3, fR1, fR2, fR3, fR4, fR5');
  // Validamos que FIDFactura tiene los datos necesarios
  if Assigned(FIDFactura) then
  begin
    if (FIDFactura.IDEmisorFactura = '') then
      raise Exception.Create('Error: IDEmisorFactura sin asignar');
    if (FIDFactura.NumSerieFactura = '') then
      raise Exception.Create('Error: NumSerieFactura sin asignar');
    if FIDFactura.FechaExpedicionFactura = 0 then
      raise Exception.Create('Error: FechaExpediciónFactura sin asignar');
  end
  else
    raise Exception.Create('Error: FIDFactura no ha sido asignado.');
  // Validamos que FFacturasRectificadas tiene los datos necesarios
  if not Assigned(FFacturasRectificadas) then
    raise Exception.Create('Error: Facturas Rectificadas no ha sido asignada.');
  // Asignamos la referencia externa
  FRefExterna := RefExterna;
  FTipoFactura:='F2';
  FSubsanacion :='N';
  FRechazoPrevio :='N';
  FTipoRectificativa :='N';
  if AnombreRazonEmisor.Length>120 then
        raise Exception.Create('Error: NombreRazonEmisor debe ser inferior o igual a 120 caracteres');
  FNombreRazonEmisor:= ANombreRazonEmisor;
  FCupon:='N';
  FNodoNecesario:=ANodoNecesario;
end;

end.

