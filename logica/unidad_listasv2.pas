unit unidad_listasv2;

interface

uses
  SysUtils,StrUtils, Classes, Generics.Collections;

type
  IListas = Interface
  ['{A1D767CA-1ED1-4E90-B32E-6CBB55AAAD69}']
  End;

type
  TL1 = Class
  Public
    class Function IVA:string;
    Class Function IGIC:string;
    class Function CeutaYMelilla:String;
    class Function OtrosImpuestos:string;
  end;
  TL2 = Class
  Public
    class Function F1:string;
    class Function F2:string;
    class Function F3:string;
    class Function R1:string;
    class Function R2:string;
    class Function R3:string;
    class Function R4:string;
    class Function R5:string;
  End;
  TL3 = Class
    Public
    class Function Sustitucion:char;
    class Function Diferencias:char;
  End;
  TL4 = class
    public
    class Function NO:char;
    class Function SI:char;
  end;
  TL5 = Class(TL4)
    // l5 hereda L4
  End;
  TL6 = Class
    public
    class Function Destinatario:char;
    class Function Tercero:char;
  End;
  TL7 = class
    Public
    class Function NIFIVA:string;
    class Function Pasaporte:string;
    Class Function DocumentoPaisResidencia:string;
    Class Function CertificadoResidencia:String;
    class Function OtroDocumentoProbatorio:String;
    class Function NoCensado:String;
  end;
  TL8A = Class
    Public
      class Function OperacionRegimenGeneral:string;
      class Function Exportacion:String;
      class Function OperacionBienesArteYColeccion:string;
      class Function RegimenEspecialOroInversion:String;
      class Function RegimenEspecialAgenciasDeViajes:String;
      class Function RegimenEspecialGrupoEntidadesIVA:string;
      class Function RegimenEspecialCriterioCaja:String;
      class Function OperacionesIPSI_IGIC:String;
      class Function FacturacionRepresentacionAgenciaViajes:String;
      class Function CobrosTercerosHonorariosPropiedadInsdustrial:string;
      class Function OperacionesArrendamientoLocalONecogio:string;
      class Function FacturaIVAPendienteCertificacionesDeObra:String;
      Class Function FacturaIVAPendienteDeventoTractoSucesivo:String;
      class Function OperacionAcogida_CapituloXI_TituloIX:string;
      class Function RecargoEquivalencia:String;
      class Function ActividadesAgriculturaGanaderiaPesca:string;
      class Function RegimenSimplificado:string;
  End;
  TL8B = class(TL8A)
    //hereda TL8A
  end;
  TL9 = Class
    public
     class Function NoExenta_SinInversion_SujetoPasivo:string;
     Class Function NoExenta_ConInversion_SujetoPasivo:string;
     class Function Operacion_NoSujeta_Arts_7_14_Otros:string;
     class Function Operacion_NoSujetaPorReglasLocalizacion:string;
  End;
  TL10 = Class
    public
      Class Function Exenta_Art20:String;
      class Function Exenta_Art21:string;
      class Function Exenta_Art22:string;
      class Function Exenta_Art23_y_Art24:string;
      class Function Exenta_Art25:string;
      class Function Exenta_Otros:string;
  End;
  // no existe TL11
  //TL12  es la huella en SH256
  TL14 = Class (TL4)
    //hereda TL4 : Si o NO
  End;
  TL15 = Class
    public
    class Function Version:string;
  End;
  TL16 = Class
    public
    class Function Expedidor_FacturaAnulada:char;
    class Function Destinatario:char;
    class Function Tercero:char;
  End;
  TL17 = Class
    public
      class Function Sin_RechazoPrevio_AEAT:char;
      class Function Con_RechazoPrevio_AEAT:char;
      class Function Registro_NoExiste_AEAT:char; // si subsanacion es N, RechazoPrevio no puede ser X. No se admiten

  End;
  { clase principal Listas }

type
  TListas = class (TInterfacedObject,IListas)
  private
    FL1:TL1;
    FL2:TL2;
    FL3:TL3;
    FL4:TL4;
    FL5:TL5;
    FL6:TL6;
    FL7:TL7;
    FL8A:TL8A;
    FL8B:TL8B;
    FL9:TL9;
    FL10:TL10;
    FL14:TL14;
    FL15:TL15;
    FL16:TL16;
    FL17:TL17;
  public
    Property L1:TL1 read FL1;
    Property L2:TL2 read FL2;
    Property L3:TL3 read FL3;
    Property L4:TL4 read FL4;
    Property L5:Tl5 read FL5;
    Property L6:TL6 read FL6;
    Property L7:TL7 read FL7;
    Property L8A:TL8A read FL8A;
    Property L8B:TL8B read FL8B;
    Property L9:TL9 read FL9;
    Property L10:TL10 read FL10;
    Property L14:TL14 read FL14;
    Property L15:TL15 read FL15;
    Property L16:TL16 read FL16;
    Property L17:TL17 read FL17;
  end;

implementation
                { Funciones L17 }
class Function TL17.Registro_NoExiste_AEAT: Char;
Begin
  result := 'X';
End;
class Function TL17.Con_RechazoPrevio_AEAT: Char;
Begin
  result := 'S';
End;
class Function TL17.Sin_RechazoPrevio_AEAT: Char;
Begin
  result := 'N';
End;

                  { Funciones L16}

Class Function TL16.Tercero: Char;
Begin
  result := 'T';
End;
Class Function TL16.Destinatario: Char;
Begin
  result := 'D';
End;
class Function TL16.Expedidor_FacturaAnulada: Char;
Begin
  result := 'E';
End;
                  { Funtiones L15 }
Class Function TL15.Version: string;
begin
  result := '1.0';
end;
                  { Funciones L10 }

class Function TL10.Exenta_Otros: string;
Begin
  result := 'E6';
End;
class Function TL10.Exenta_Art25: string;
Begin
  result := 'E5';
End;
class Function TL10.Exenta_Art23_y_Art24: string;
Begin
  result := 'E4';
End;
class Function TL10.Exenta_Art22: string;
Begin
  result := 'E3';
End;
class Function TL10.Exenta_Art21: string;
Begin
  result :='E2';
End;
class Function TL10.Exenta_Art20: string;
Begin
  result := 'E1';
End;

                    {Funciones L9 }

class Function TL9.Operacion_NoSujetaPorReglasLocalizacion: string;
Begin
   result := 'N2';
End;
class Function TL9.Operacion_NoSujeta_Arts_7_14_Otros: string;
Begin
  result := 'N1';
End;
Class Function TL9.NoExenta_ConInversion_SujetoPasivo: string;
Begin
  result := 'S2';
End;
Class Function TL9.NoExenta_SinInversion_SujetoPasivo: string;
Begin
  result := 'S1';
End;
           { Funciones de L8A / L8B }

class Function TL8A.RegimenSimplificado: string;
Begin
  result :='20';
End;
class Function TL8A.ActividadesAgriculturaGanaderiaPesca: string;
begin
  result := '19';
end;
Class Function TL8A.RecargoEquivalencia: string;
Begin
  result := '18';
End;
class Function TL8A.OperacionAcogida_CapituloXI_TituloIX: string;
Begin
  result :='17';
End;
class Function TL8A.FacturaIVAPendienteDeventoTractoSucesivo: string;
Begin
  result := '15';
End;
class Function TL8A.FacturaIVAPendienteCertificacionesDeObra: string;
begin
  result := '14';
end;
class Function TL8A.OperacionesArrendamientoLocalONecogio: string;
begin
  result :='11';
end;
class Function TL8A.CobrosTercerosHonorariosPropiedadInsdustrial: string;
Begin
  result := '10';
End;
class Function TL8A.FacturacionRepresentacionAgenciaViajes: string;
Begin
  result := '09'
End;
class Function TL8A.OperacionesIPSI_IGIC: string;
Begin
  result := '08';
End;
class Function TL8A.RegimenEspecialCriterioCaja: string;
Begin
  result := '07';
End;
Class Function TL8A.RegimenEspecialGrupoEntidadesIVA: string;
Begin
  result := '06';
End;
class Function TL8A.RegimenEspecialAgenciasDeViajes: string;
Begin
  result := '05';
End;
class Function TL8A.RegimenEspecialOroInversion: string;
Begin
  result := '04';
End;
class Function TL8A.OperacionBienesArteYColeccion: string;
Begin
  result := '03';
End;
class Function TL8A.Exportacion: string;
Begin
  result := '02';
End;
class Function TL8A.OperacionRegimenGeneral: string;
Begin
  result := '01';
End;

           { Funciones de L7 }

class Function TL7.NoCensado: string;
Begin
  result := '07';
End;
class Function TL7.OtroDocumentoProbatorio: string;
Begin
  result := '06';
End;
class Function TL7.CertificadoResidencia: string;
Begin
  result := '05';
End;
class Function TL7.DocumentoPaisResidencia: string;
Begin
  result := '04';
End;
class Function TL7.Pasaporte: string;
Begin
  result := '03';
End;
class Function TL7.NIFIVA: string;
Begin
  result := '02';
End;

          {  Funciones de L6  }

class Function TL6.Tercero: Char;
Begin
  result :='T';
End;

class Function TL6.Destinatario: Char;
Begin
  result :='D';
End;
       { Functiones de L4 , L5 , L14 }

class Function TL4.SI: Char;
Begin
  result :='S';
End;
class Function TL4.NO: Char;
Begin
  result := 'N';
End;
       {  Functiones de L3  }

class Function TL3.Diferencias: Char;
Begin
  result:='I';
End;
class Function TL3.Sustitucion: Char;
Begin
   result:='S';
End;

      { Functiones de L2 }

class Function TL2.R5: string;
Begin
  result:='R5';
End;
class Function TL2.R4: string;
Begin
  result:='R4';
End;
class Function TL2.R3: string;
Begin
  result:='R3';
End;
class Function TL2.R2: string;
Begin
  result:='R2';
End;
class Function TL2.R1: string;
Begin
  result:='R1';
End;
class Function TL2.F3: string;
Begin
  result:='F3';
End;
class Function TL2.F2: string;
Begin
  result:='F2';
End;
class Function TL2.F1: string;
Begin
  result:='F1';
End;

      {Funciones de L1}

class Function TL1.OtrosImpuestos: string;
Begin
  result:='05';
End;
class Function TL1.CeutaYMelilla: string;
Begin
  result:='03';
End;
Class Function TL1.IGIC: string;
Begin
  result:='02';
End;
class Function TL1.IVA:string;
begin
  result :='01';
end;

initialization


finalization


end.

