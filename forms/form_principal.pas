unit form_principal;
 //DaMoRaDEV, SDK VeriFactu 0.1.0
interface

uses
  System.SysUtils,
  dateutils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  xml.XMLDoc,
  activex,
  xml.XMLIntf, Xml.xmldom, Xml.Win.msxmldom, Vcl.Imaging.pngimage;

type
  TFormPpal = class(TForm)
    MemoLogs: TMemo;
    panelBotones: TPanel;
    btnXMLEventos: TButton;
    codigoQR: TImage;
    btnGenerarQR: TButton;
    btnFirmar: TButton;
    btnHuella: TButton;
    gboxRegistroAlta: TGroupBox;
    cboxHayDestinatarios: TCheckBox;
    cboxEsPrimerRegistro: TCheckBox;
    cboxHayRequerimientoEAT: TCheckBox;
    cboxHayFacturasSustituidas: TCheckBox;
    cboxHayFacturasRectificadas: TCheckBox;
    btnXMLFacturaAlta: TButton;
    cboxRegistroAnulacion: TGroupBox;
    btnGenerarXMLAnulacion: TButton;
    cboxHayRechazoPrevio: TCheckBox;
    cboxSinRegistroPrevio: TCheckBox;
    procedure btnXMLFacturaAltaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnHuellaClick(Sender: TObject);
    procedure btnGenerarXMLAnulacionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPpal: TFormPpal;

implementation

{$R *.dfm}
uses
  clase_cabecera, clase_RegistroAlta,clase_XMLFactura,clase_ImporteRectificacion,
  clase_Tercero,clase_Destinatarios,clase_version,clase_desglose,clase_encadenamiento,
  clase_DatosRegistroAlta,clase_Huella,unidad_logicaFechas,clase_RegistroAnulacion,
  clase_GeneradoPor,
  clase_IDFactura, clase_FacturasRectificadas,clase_FacturasSustituidas,unidad_listasv2;


procedure TFormPpal.btnGenerarXMLAnulacionClick(Sender: TObject);
var
  cabecera: TCabecera;
  RegAlta: TRegistroAlta;
  IDFactura: TIDFactura;
  XMLFactura:TXMLFactura;
  Encadenamiento:Tencadenamiento;
  RegAnulacion:TRegistroAnulacion;
  GeneradoPor:TGeneradoPor;
begin
 // factura Anulacion
    cabecera := TCabecera.Create('Empresa Test', '12345678Z');
    IDFactura := TIDFactura.Create('12345678Z','fact001Anulada');
    GeneradoPor := TGeneradoPor.Create('Empresa Test','12345678Z');
    Encadenamiento := Tencadenamiento.Create(TL4.SI);
    RegAlta := TRegistroAlta.create(False);
    RegAnulacion:= TRegistroAnulacion.Create(IDFactura,GeneradoPor,Encadenamiento,true) ;
    Memologs.Lines.Text := XMLFactura.GenearXML(1,cabecera,RegAlta,RegAnulacion).XML.Text ;
    RegAlta.Free;
    RegAnulacion.Free;
end;

procedure TFormPpal.btnHuellaClick(Sender: TObject);
var DatosRegistroAlta:TDatosRegistroAlta;
begin
  DatosRegistroAlta:= TDatosRegistroAlta.Create;
  DatosRegistroAlta.IDEmisorFactura:='12345678Z';
  DatosRegistroAlta.NumSerieFactura:='Serie1234';
  DatosRegistroAlta.FechaExpedicionFactura:=FormatoFechaDate('12-12-2024') ;
  DatosRegistroAlta.TipoFactura:='F2';
  DatosRegistroAlta.CuotaTotal := 21;
  DatosRegistroAlta.ImporteTotal:=100;
  DatosRegistroAlta.PrimerRegistro:='S';
  DatosRegistroAlta.Huella:='';// es primer registro
  DatosRegistroAlta.FechaHoraHusoGenRegistro:=ObtenerFechaConHusoHorario(now);
  MemoLogs.Clear;
  Memologs.Lines.Add(THuella.HuellaRegistroAlta(DatosRegistroAlta));
  DatosRegistroAlta.Free;
end;

procedure TFormPpal.btnXMLFacturaAltaClick(Sender: TObject);
var
  cabecera: TCabecera;
  RegAlta: TRegistroAlta;
  IDFactura: TIDFactura;
  FacturasRectificadas: TFacturasRectificadas;
  FacturasSustituidas :TFacturasSustiuidas;
  ImporteRectificacion:TImporteRectificacion;
  XMLFactura:TXMLFactura;
  Tercero:TTercero;
  Destinatarios:TDestinatarios;
  Desglose:TDesglose;
  Encadenamiento:Tencadenamiento;
  RegAnulacion:TRegistroAnulacion;
begin
  XMLFactura := nil;
   try
     RegAnulacion := TRegistroAnulacion.Create(False);
     FormatDateTime('dd-mm-yyyy',now);
     cabecera := TCabecera.Create('Empresa Test', '12345678Z');
     IDFactura := TIDFactura.Create('12345678Z','fact001test');
     Tercero := TTercero.Create(False);
     Desglose := TDesglose.Create(1,i01);
     Desglose.ClaveRegimen:=TL8A.OperacionRegimenGeneral ; // regimen general
     Desglose.CalificacionOperacion:= TL9.NoExenta_SinInversion_SujetoPasivo; // no exenta
     Desglose.OperacionExenta :='';//no esta exenta  L10
     Desglose.TipoImpositivo :=100.50;
     Desglose.BaseImponibleOImporteNoSujeto:=0;
     Desglose.BaseImponibleACoste:=0;
     Desglose.CuotaRepercutida:=100.50;
     Desglose.TipoRecargoEquivalencia:=100.50;
     Desglose.CuotaRecargoEquivalencia:=100.50;
     // Encadenamiento
     if cboxEsPrimerRegistro.Checked=true then encadenamiento:=Tencadenamiento.Create(TL4.SI)
        else
           Begin
             encadenamiento := Tencadenamiento.Create(TL4.NO,'12345678Z','SerieAnterior01',now,'aqui va el hash anterior') ;
           End;
     // facturas Rectificadas
     if Assigned(cboxHayFacturasRectificadas) and (cboxHayFacturasRectificadas.Checked = true) then
          begin
           // acces violation, sevisar los constructores
           FacturasRectificadas := TFacturasRectificadas.Create(true,'12345678Z','111Facsustituida',now);
           ImporteRectificacion := TImporteRectificacion.create(true,10.50,5.60,16.20 );
          end
     else
          Begin
             FacturasRectificadas := TFacturasRectificadas.Create(false);
             ImporteRectificacion := TImporteRectificacion.Create(false);
          End;
     // facturas sustituidas
     if cboxHayFacturasSustituidas.Checked = true then
            FacturasSustituidas:= TFacturasSustiuidas.Create(1,True,'12345678Z','1234factsustituida',now)
     else  FacturasSustituidas := TFacturasSustiuidas.Create(false) ;
     //destinatarios
     if cboxHayDestinatarios.Checked = true  then
            Destinatarios := TDestinatarios.Create(true,'Destinatario1','12345678Z',1)
     else Destinatarios := TDestinatarios.Create(false);
     // Hay Requerimiento
     if cboxHayrequerimientoEAT.Checked = true then
          Begin
            Cabecera.RequeridoPorEAT:=true;
            Cabecera.RemisionRequerimiento_RefRequerimiento:='ref requerimiento';
            Cabecera.RemisionRequerimiento_FinRequerimiento:=TL4.SI; //s o N
          End;
     //ShowMessage(' tercero') ;
     RegAlta := TRegistroAlta.Create('Empresa Test',IDFactura,'refext001',fF2,FacturasRectificadas,FacturasSustituidas,Tercero,Destinatarios,ImporteRectificacion,Desglose,Encadenamiento,true);
     RegAlta.DescripcionOperacion:='Venta minorista en factura simplificada';
     RegAlta.FacturaSinIdentifDestinatarioArt61d:=TL4.NO;
     RegAlta.FacturaSimplificadaArt7273:=TL4.NO;
     RegAlta.EmitidaPorTerceroDestinatario:=TL4.NO;
     RegAlta.Macrodato:=TL4.NO;
     RegAlta.SETSubsanacion(TL4.NO);
     RegAlta.SETRechazoPrevio(TL17.Sin_RechazoPrevio_AEAT);
     RegAlta.FechaOperacion:=now;
     RegAlta.CuotaTotal:=21;
     RegAlta.ImporteTotal:=100;
     RegAlta.NodoNecesario:=true;
     //Creacion de la factura
     Memologs.Lines.Text := XMLFactura.GenearXML(1,Cabecera,RegAlta,RegAnulacion).XML.Text;
   except
        on E:Exception do raise Exception.Create('Error XML Factura : '+E.ToString);
   end;
    RegAlta.Free; // libera todas las clases en su destructor
    RegAnulacion.Free;
end;


procedure TFormPpal.FormShow(Sender: TObject);
begin
   FormPpal.caption:='Test SDK '+TVersion.NumeroVersion+'     Tipo: '+Tversion.TipoVersion+'     Fecha : '+Tversion.FechaVersion;
end;


end.
