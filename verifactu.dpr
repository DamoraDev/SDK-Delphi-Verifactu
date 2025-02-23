program verifactu;

uses
  Vcl.Forms,
  form_principal in 'forms\form_principal.pas' {FormPpal},
  clase_cabecera in 'Clases\clase_cabecera.pas',
  clase_IDFactura in 'Clases\clase_IDFactura.pas',
  unidad_logica in 'logica\unidad_logica.pas',
  clase_ImporteRectificacion in 'Clases\clase_ImporteRectificacion.pas',
  clase_Huella in 'Clases\clase_Huella.pas',
  clase_desglose in 'Clases\clase_desglose.pas',
  clase_RegistroAlta in 'Clases\clase_RegistroAlta.pas',
  clase_FacturasRectificadas in 'Clases\clase_FacturasRectificadas.pas',
  clase_FacturasSustituidas in 'Clases\clase_FacturasSustituidas.pas',
  clase_RegistroFactura in 'Clases\clase_RegistroFactura.pas',
  clase_XMLFactura in 'Clases\clase_XMLFactura.pas',
  clase_Tercero in 'Clases\clase_Tercero.pas',
  clase_Destinatarios in 'Clases\clase_Destinatarios.pas',
  clase_version in 'Clases\clase_version.pas',
  clase_encadenamiento in 'Clases\clase_encadenamiento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPpal, FormPpal);
  Application.Run;
end.
