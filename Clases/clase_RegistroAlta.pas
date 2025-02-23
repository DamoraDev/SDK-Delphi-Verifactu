unit clase_RegistroAlta;
//DaMoRaDEV, SDK VeriFactu 0.2.0
interface
uses
  Classes, Sysutils,
  clase_IDFactura,vcl.Dialogs,
  clase_FacturasRectificadas,
  clase_FacturasSustituidas,
  clase_ImporteRectificacion,
  clase_Desglose,
  clase_Tercero,clase_Destinatarios,
  unidad_logica;
Type IRegistroAlta = Interface
     ['{0C849AFB-8F4C-4C01-9E18-B766C613A803}']
End;

type
  TFormatoFactura = (fF1, fF2, fF3, fR1, fR2, fR3, fR4, fR5);
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
  public
    property IDFactura: TIDFactura read FIDFactura write FIDFactura;
    property RefExterna: string read FRefExterna write FRefExterna;
    property NombreRazonEmisor: string read FNombreRazonEmisor write FNombreRazonEmisor;
    property Subsanacion: char read FSubsanacion write FSubsanacion;
    property RechazoPrevio: char read FRechazoPrevio write FRechazoPrevio;
    property TipoFactura: string read FTipoFactura write FTipoFactura;
    property TipoRectificativa: char read FTipoRectificativa write FTipoRectificativa;
    property FacturasRectificadas: TFacturasRectificadas read FFacturasRectificadas write FFacturasRectificadas;
    property FacturasSustituidas:TFacturasSustiuidas read FFacturasSustituidas write FFacturasSustituidas;
    Property NodoIDFactura: TnodoIDFactura read FNodoIDFactura write FNodoIDFactura;
    Property IDVersion : string read FIDVersion write FIDVersion;
    Property ImporteRectificacion : TImporteRectificacion read FImporteRectificacion write FImporteRectificacion;
   // nuevas properties  16 02 2025
    Property FechaOperacion : TDate  read FFechaOperacion write FFechaOperacion;
    Property DescripcionOperacion : string read  FDescripcionOperacion write FDescripcionOperacion;
    Property FacturaSimplificadaArt7273:char read FFacturaSimplificadaArt7273 write FFacturaSimplificadaArt7273;
    Property FacturaSinIdentifDestinatarioArt61d : char read FFacturaSinIdentifDestinatarioArt61d write FFacturaSinIdentifDestinatarioArt61d;
    Property Macrodato:char read FMacrodato write FMacrodato;
    Property EmitidaPorTerceroDestinatario:char read FEmitidaPorTerceroDestinatario write FEmitidaPorTerceroDestinatario;
    Property Tercero:TTercero read FTercero write FTercero;
    property Destinatarios:TDestinatarios read FDestinatarios write FDestinatarios;
    Property Cupon:char read FCupon write Fcupon;
    Property Desglose:TDesglose read FDesglose write FDesglose;
   // constructor Create(AIDFactura: TIDFactura; RefExterna: string; TipoFactura: TFormatoFactura);
    constructor Create(ANombreRazonEMisor:string;AIDFactura: TIDFactura; RefExterna: string;TipoFactura: TFormatoFactura;
                       AFacturasRectificadas: TFacturasRectificadas;AFacturasSustituidas:TFacturasSustiuidas;
                       ATercero:TTercero;ADestinatarios:TDestinatarios;AImporteRectificacion:TImporteRectificacion;ADesglose:TDesglose);
    destructor Destroy;Override;
    Procedure Free;

  end;

var
  NombreNodo: string = ''; // nombre nodos para posicionar las subclases en el XML

implementation

{ Constructores y Destructores }


procedure TRegistroAlta.Free;
begin
  try
    Destroy;
  except
    on E: Exception do
      raise Exception.Create('Error al liberar RegistroAlta: ' + E.Message);
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
  except
    on E: Exception do
      raise Exception.Create('Error al liberar RegistroAlta: ' + E.Message);
  end;
  inherited Destroy;
end;



constructor TRegistroAlta.Create(ANombreRazonEMisor:string;AIDFactura: TIDFactura;
    RefExterna: string;TipoFactura: TFormatoFactura; AFacturasRectificadas: TFacturasRectificadas;
    AFacturasSustituidas:TFacturasSustiuidas;ATercero:TTercero;ADestinatarios:TDestinatarios;
    AimporteRectificacion:TImporteRectificacion;ADesglose:Tdesglose);
begin
  inherited Create;
  FIDversion:='1.0';
  // Asignamos las instancias pasadas al constructor
  FIDFactura := AIDFactura;
  FFacturasRectificadas := AFacturasRectificadas;
  FFacturasSustituidas := AFacturasSustituidas;
  FTercero := ATercero;
  FDestinatarios:=ADestinatarios;
  FImporteRectificacion:=AImporteRectificacion;
  FDesglose:=ADesglose;
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
end;

end.

