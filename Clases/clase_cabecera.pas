unit clase_cabecera;
//DaMoRaDEV, SDK VeriFactu 0.1.5
interface
uses
  Classes, Sysutils, xml.XMLDoc, xml.XMLIntf,xml.xmldom,msxmldom, unidad_logica;
type
  ICabecera = Interface
    ['{185A691E-2C28-4255-803E-5469C97FB7E1}']
  End;
  TCabecera = Class(TInterfacedObject, ICabecera)
  private
    FObligadaEmision_NombreRazon: string; // 120 alfanumérico
    FObligadaEmision_NIF: string; // 9 dígitos alfanumérico
    FUsaRepresentante: Boolean; // si factura otra persona o empresa s/n
    FRepresentante_NombreRazon: string; // 120 alfanumérico
    FRepresentante_NIF: string; // 9 dígitos alfanumérico
   // FDejarSistemaVerifactu: boolean; // si se desea dejar el sistema verifactu para casos voluntarios
    FRemisionVoluntaria_FechaFinVerifactu: TDate; // dd-mm-yyyy
    FHayIncidencia: boolean; // si hay una incidencia técnica para dejar el sistema verifactu
    FRemisionVoluntaria_Incidencia: char; // L4 : S/N
    FRequeridoPorEAT: boolean; // si hay requerimiento por Hacienda
    FRemisionRequerimiento_RefRequerimiento: string; // 120 alfanumérico
    FRemisionRequerimiento_FinRequerimiento: char; // L4 : S/N
  public
    Procedure SETRepresentanteNombre(NombreRazon:string);
    Procedure SETRepresentanteNIF(NIF:string);
    Procedure SETFechaFinVerifactu(Fecha:TDate);
    Procedure SETIncidencia(incidencia:boolean);
    property ObligadaEmision_NombreRazon: string read FObligadaEmision_NombreRazon write FObligadaEmision_NombreRazon;
    property ObligadaEmision_NIF: string read FObligadaEmision_NIF write FObligadaEmision_NIF;
    property UsaRepresentante: boolean read FUsaRepresentante write FUsaRepresentante;
    property Representante_NombreRazon: string read FRepresentante_NombreRazon write SETRepresentanteNombre;
    property Representante_NIF: String read FRepresentante_NIF write SETRepresentanteNIF;
    //property DejarSistemaVerifactu: boolean read FDejarSistemaVerifactu write FDejarSistemaVerifactu;
    property RemisionVoluntaria_FechaFinVerifactu: TDate read FRemisionVoluntaria_FechaFinVerifactu write SETFechaFinVerifactu;
    property HayIncidencia: boolean read FHayIncidencia write SETIncidencia;
    property RemisionVoluntaria_Incidencia: char read FRemisionVoluntaria_Incidencia write FRemisionVoluntaria_Incidencia;
    property RequeridoPorEAT: boolean read FRequeridoPorEAT write FRequeridoPorEAT;
    property RemisionRequerimiento_RefRequerimiento: string read FRemisionRequerimiento_RefRequerimiento write FRemisionRequerimiento_RefRequerimiento;
    property RemisionRequerimiento_FinRequerimiento: char read FRemisionRequerimiento_FinRequerimiento write FRemisionRequerimiento_FinRequerimiento;
    constructor Create(NombreRazon: string; NIF: string);
    destructor Destroy; override;
    procedure Free;


  end;
implementation
                   { Setters RemisionVoluntaria }
Procedure TCabecera.SETIncidencia(incidencia: Boolean);
Begin
  FHayIncidencia := incidencia;
  if incidencia = true  then  FRemisionVoluntaria_Incidencia:='S'
      else FRemisionVoluntaria_Incidencia:='N';
End;

Procedure  Tcabecera.SETFechaFinVerifactu(Fecha: TDate);
Begin
    if RequeridoPorEAT= false then  raise Exception.Create('Error: No hay requerimiento EAT, su valor es FALSE');
    if Hayincidencia = false then  raise Exception.Create('Error: No hay indicencia , su valor es FALSE');
    FormatDateTime('dd-mm-yyyy',fecha);
    FRemisionVoluntaria_FechaFinVerifactu:=Fecha;
End;

                  { Setters  Representante }

Procedure TCabecera.SETRepresentanteNIF(NIF: string);
Begin
 if UsaRepresentante=false then raise Exception.Create('Error: Usa Representante es False. Debe ser True');
 if not ValidarNIF(NIF) then
    raise Exception.Create('Error: NIF no válido');
 FRepresentante_NIF:=NIF;
End;

Procedure TCabecera.SETRepresentanteNombre(NombreRazon: string);
Begin
  if UsaRepresentante=false then raise Exception.Create('Error: Usa Representante es False. Debe ser True');
  if NombreRazon.Length>120  then raise Exception.Create('Error: NombreRazon debe ser inferior a 120 caracteres');
  FRepresentante_NombreRazon := NombreRazon;
End;

                { Funciones }






{ Constructores y Destructores }
procedure TCabecera.Free;
begin
  if self <> nil then
    destroy;
end;

destructor TCabecera.Destroy;
begin
  inherited destroy;
end;

constructor TCabecera.Create(NombreRazon: string; NIF: string);
begin
  if NombreRazon.Length > 120 then
    raise Exception.Create('Error: Nombre Razon superior a 120 caracteres');
  FObligadaEmision_NombreRazon := NombreRazon;
  if not ValidarNIF(NIF) then
    raise Exception.Create('Error : NIF no válido');
  FObligadaEmision_NIF := NIF;
  FUsaRepresentante := False;
  FRequeridoPorEAT := False;
  //FDejarSistemaVerifactu := False;
end;
end.

