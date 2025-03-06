unit clase_ImporteRectificacion;
//DaMoRaDEV, SDK VeriFactu 0.2.0
interface
Uses classes,sysutils;
type IImporteRectificacion = interface
   ['{88D2A6F0-FDB2-49A4-A3A0-088588274448}']
end;
type TImporteRectificacion = Class(TInterfacedObject,IImporteRectificacion)
     Private
       FBaseRectificada :currency;
       FCuotaRectificada:currency;
       FCuotaRecargoRectificado:currency;
       FNodoNecesario: boolean;
     Public
       Property BaseRectificada:currency read FBaseRectificada write FBaseRectificada ;
       Property CuotaRectificada:currency read FCuotaRectificada write FCuotaRectificada;
       Property CuotaRecargoRectificado:currency read FCuotaRecargoRectificado write FCuotaRecargoRectificado;
       Property NodoNecesario :boolean read FNodoNecesario write FNodoNecesario;
       Constructor Create(ANodoNecesario:boolean);Overload;
       Constructor Create(AnodoNecesario:Boolean;ABaseRectificada:currency;ACuotaRectificada:Currency;CuotaRecargoRectificado:currency);Overload;
       Destructor Destroy; Override;
       Procedure Free;
End;

implementation

{ Constructores y Destructores }

  Procedure TImporteRectificacion.Free;
  Begin
    if self<>nil then destroy;

  End;

  Destructor TImporteRectificacion.Destroy;
  Begin
    inherited Destroy;
  End;

  Constructor TimporteRectificacion.Create(ANodoNecesario: Boolean);
  Begin
     if ANodoNecesario = true then raise Exception.Create('Error en clase ImporteRectificacion : Es es necesario indicar BaseRectificada,CuotaRectificada ni CuotaRecargoRectificado');
     NodoNecesario := ANodoNecesario;
  End;
  Constructor TImporteRectificacion.Create(AnodoNecesario: Boolean; ABaseRectificada: Currency; ACuotaRectificada: Currency; CuotaRecargoRectificado: Currency);
  Begin

    if ANodoNecesario = false then
      raise Exception.Create('Error en clase ImporteRectificacion : Si el Nodo no es necesario no es necesario indicar BaseRectificada,CuotaRectificada ni CuotaRecargoRectificado');
    BaseRectificada := ABaseRectificada;
    CuotaRectificada := ACuotaRectificada;
    CuotaRecargoRectificado := CuotaRecargoRectificado;
    NodoNecesario:=ANodonecesario;
  End;
end.
