unit clase_DatosRegistroAnulacion;

interface
Uses SysUtils, Classes, Xml.XMLDoc, Xml.XMLIntf, shellapi, windows, unidad_logica;

Type IDatosRegistroAnulacion= Interface
  ['{E7AE7E35-9A05-459C-ABFE-4E8E93DA0CCB}']
End;

type TDatosRegistroAnulacion = Class( TinterfacedObject, IDatosRegistroAnulacion)
      Private
        FIDEmisorFacturaAnulada:string; // alfanumerico 9 formato nif
        FNumSerieFacturaAnulada :string;// alfanumerico 60
        FFechaExpedicionFacturaAnulada :Tdate;// formato dd-mm-yyy
        FHuellaAnterior:string;// alfanumerico 64 caracteres
        FFechaHoraHusoGenRegistro:TDateTime; // formato ISO con huso horario
        FPrimerRegistro:char; // indicador del primer registro o no
      Public
        Property IDEmisorFacturaAnulada:string  read FIDEmisorFacturaAnulada write FIDEmisorFacturaAnulada;
        Property NumSerieFacturaAnulada :string read FNumSerieFacturaAnulada write FNumSerieFacturaAnulada;
        Property FechaExpedicionFacturaAnulada :Tdate  read FFechaExpedicionFacturaAnulada write FFechaExpedicionFacturaAnulada;
        Property HuellaAnterior:string   read FHuellaAnterior write FHuellaAnterior;
        Property FechaHoraHusoGenRegistro:TDateTime read FFechaHoraHusoGenRegistro write FFechaHoraHusoGenRegistro;
        Property PrimerRegistro:char  read FPrimerRegistro write FPrimerRegistro;
        Constructor Create;
        Destructor Destroy;Override;
        Procedure Free;
End;

implementation

     { *** Constructores y destructores ***}

Procedure  TDatosRegistroAnulacion.Free;
Begin
  if self<>nil  then Destroy;
End;

Destructor TDatosRegistroAnulacion.Destroy;
Begin
   inherited Destroy;
End;

Constructor TDatosRegistroAnulacion.Create;
var  DateTimeStr,TimeZoneStr:string;
  Begin
   PrimerRegistro:='N' ;
   IDEmisorFacturaAnulada := '';
   NumSerieFacturaAnulada := '';
   FechaExpedicionFacturaAnulada := StrToDate( FormatDateTime('dd-mm-yyyy',now));
  End;
end.
