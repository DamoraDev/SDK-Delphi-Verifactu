unit clase_desglose;
//DaMoRaDEV, SDK VeriFactu 0.1.0
 {
 	    <Desglose>
		    <DetalleDesglose  (1-12)>
				<Impuesto formato="Alfanumérico" Longitud="1" tipo="L1"></impuesto>
				<ClaveRegimen formato="Alfanumérico" Longitud="2" tipo="L8A/L8B"></ClaveRegimen>
				<CalificacionOperacion formato="Alfanumérico" Longitud="2" tipo="L9"></CalificacionOperacion>
				<OperacionExenta formato="Alfanumérico" Longitud="2" tipo="L10"></OperacionExenta>
				<TipoImpositivo formato="Decimal" Longitud="3,2" tipo="decimal"></TipoImpositivo>
				<BaseImponibleOImporteNoSujeto formato="Decimal" Longitud="12,2" tipo="Decimal"></BaseImponibleOImporteNoSujeto>
				<BaseImponibleACoste formato="Decimal" Longitud="12,2" tipo="Decimal"></BaseImponibleACoste>
				<CuotaRepercutida  formato="Decimal" Longitud="12,2" tipo="Decimal"></CuotaRepercutida>
				<TipoRecargoEquivalencia  formato="Decimal" Longitud="3,2" tipo="Decimal"></TipoRecargoEquivalencia>
				<CuotaRegarcoEquivalencia  formato="Decimal" Longitud="12,2" tipo="Decimal"></CuotaRegarcoEquivalencia>
			</DetalleDesglose>
		</Desglose>

 }
interface
uses
  Classes, Sysutils, xml.XMLDoc, xml.XMLIntf,xml.xmldom,msxmldom, unidad_logica;

type FormatoImpuestos =(i01,i02,i03,i05);
     SetOfImpuestos = Set of FormatoImpuestos;
     FormatoClaveRegimen =(r01,r02,r09,r10,r20,r11);
     SetOfClaveRegimen = Set of FormatoClaveRegimen;

type IDesglose = Interface
  ['{94DE046B-FE5E-414E-9769-774B509F5281}']
End;

type TDesglose = Class(TInterfacedObject, IDesglose)
    Private
       FCantidadDesglose:integer;
       FImpuesto:SetOfImpuestos; // L1 01:iva, 02: importacion ceuta y melilla, 03:igic,05:otros.
       FvalorImpuesto:string;
       FClaveRegimen:string;//alfanumérico 2 L8A L8B
       {
        01	Operación de régimen general.
        02	Exportación.
        09	Facturación de las prestaciones de servicios de agencias de viaje que actúan
            como mediadoras en nombre y por cuenta ajena (D.A.4ª RD1619/2012)
        10	Cobros por cuenta de terceros de honorarios profesionales o de derechos
            derivados de la propiedad industrial, de autor u otros por cuenta de sus socios,
            asociados o colegiados efectuados por sociedades, asociaciones, colegios
            profesionales u otras entidades que realicen estas funciones de cobro.
        20	Régimen simplificado
        11	Operaciones de arrendamiento de local de negocio.

       }
       FCalificacionOperacion :string ;//alfanumérico 2L9
       {
           S1	Operación Sujeta y No exenta - Sin inversión del sujeto pasivo.
           S2	Operación Sujeta y No exenta - Con Inversión del sujeto pasivo
           N1	Operación No Sujeta artículo 7, 14, otros.
           N2	Operación No Sujeta por Reglas de localización.

       }
       FOperacionExenta :string;// alfanumérico 2 L10
       {
            E1	Exenta por el artículo 20
            E2	Exenta por el artículo 21
            E3	Exenta por el artículo 22
            E4	Exenta por los artículos 23 y 24
            E5	Exenta por el artículo 25
            E6	Exenta por otros
       }
       FTipoImpositivo : double; //3.2  numerico
       FBaseImponibleOImporteNoSujeto:currency;//12,2 numerico
       FBaseImponibleACoste:currency; //12,2 numerico
       FCuotaRepercutida:Currency;//12,2 numerico
       FTipoRecargoEquivalencia:double;//3,2 numerico
       FCuotaRecargoEquivalencia:currency;//12,2 numerico
    Public
       Property ValorImpuesto:string read FValorImpuesto;
       Property CantidadDesglose:integer read FcantidadDesglose write FcantidadDesglose;
       Property Impuesto:SetOfImpuestos read Fimpuesto write FImpuesto;
       Property ClaveRegimen:string read FClaveRegimen write FClaveRegimen;
       Property CalificacionOperacion :string read FCalificacionOperacion write FCalificacionOperacion;
       property OperacionExenta:string read FOperacionExenta write FOperacionExenta;
       Property TipoImpositivo : double read FTipoImpositivo write FTipoImpositivo;
       Property BaseImponibleOImporteNoSujeto:currency read FBaseImponibleOImporteNoSujeto write FBaseImponibleOImporteNoSujeto;
       Property BaseImponibleACoste:currency read FBaseImponibleACoste write FBaseImponibleACoste;
       Property CuotaRepercutida:currency read FCuotaRepercutida write FCuotaRepercutida;
       Property TipoRecargoEquivalencia:double read FTipoRecargoEquivalencia write FTipoRecargoEquivalencia;
       Property CuotaRecargoEquivalencia:currency read FCuotaRecargoEquivalencia write FCuotaRecargoEquivalencia;
       Constructor Create(AcantidadDesglose:integer;Aimpuesto:FormatoImpuestos);
       Destructor Destroy; Override;
       Procedure Free;

End;
implementation
 { constructores y destructores}

Procedure TDesglose.Free;
Begin
  if self<> nil then destroy;
End;

Destructor TDesglose.Destroy;
Begin
  inherited Destroy;
End;

  constructor TDesglose.Create(AcantidadDesglose: Integer;Aimpuesto:FormatoImpuestos);
    begin
      if ACantidadDesglose>12 then
            raise Exception.Create('Error en Clase Desglose : Cantidad Desglose no puede ser mayor de 12');
      FCantidadDesglose := AcantidadDesglose; // 1-12
      if Aimpuesto in [i01,i02,i03,i05] then  FImpuesto:=[Aimpuesto]
         else raise  Exception.Create('Error en Clase Desglose : Impuestos debe de ser ; i01: IVA,i02: Ceuta y Melilla,i03: igic Canarias,i05: Otros');
      if Fimpuesto=[i01] then FValorImpuesto := '01';  //iva
      if Fimpuesto=[i02] then FValorImpuesto := '02';  // ceuta y melilla
      if Fimpuesto=[i03] then FValorImpuesto := '03';  //igic canarias
      if Fimpuesto=[i05] then FValorImpuesto := '05';  // otro
      //FImpuesto := '01';
      FClaveRegimen := '01';
      FCalificacionOperacion := 'S1';
      FOperacionExenta := '';
      // Validación y asignación de valores con formato requerido
      FTipoImpositivo := 123.45; // Valor ejemplo
      if Length(FormatFloat('000.00', FTipoImpositivo)) > 6 then
        raise Exception.Create('Error Clase Desglose : TipoImpositivo no cumple con el formato 3,2');

      FBaseImponibleOImporteNoSujeto := 1234567890.12; // Valor ejemplo
      if Length(FormatFloat('000000000000.00', FBaseImponibleOImporteNoSujeto)) > 15 then
        raise Exception.Create('Error Clase Desglose : BaseImponibleOImporteNoSujeto no cumple con el formato 12,2');

      FBaseImponibleACoste := 1234567890.12; // Valor ejemplo
      if Length(FormatFloat('000000000000.00', FBaseImponibleACoste)) > 15 then
        raise Exception.Create('Error Clase Desglose : BaseImponibleACoste no cumple con el formato 12,2');

      FCuotaRepercutida := 1234567890.12; // Valor ejemplo
      if Length(FormatFloat('000000000000.00', FCuotaRepercutida)) > 15 then
        raise Exception.Create('Error Clase Desglose : CuotaRepercutida no cumple con el formato 12,2');

      FTipoRecargoEquivalencia := 123.45; // Valor ejemplo
      if Length(FormatFloat('000.00', FTipoRecargoEquivalencia)) > 6 then
        raise Exception.Create('Error Clase Desglose : TipoRecargoEquivalencia no cumple con el formato 3,2');

      FCuotaRecargoEquivalencia := 1234567890.12; // Valor ejemplo
      if Length(FormatFloat('000000000000.00', FCuotaRecargoEquivalencia)) > 15 then
        raise Exception.Create('Error Clase Desglose : CuotaRecargoEquivalencia no cumple con el formato 12,2');
    end;

end.
