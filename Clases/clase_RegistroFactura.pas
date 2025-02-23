unit clase_RegistroFactura;
//DaMoRaDEV, SDK VeriFactu 0.1.0
   {
    El Nodo Registro factura lleva contador (1-1000);
    RegistroAlta
    RegistroAnulacion
    Eventos
   }
interface
uses  Classes, Sysutils,
      clase_RegistroAlta,
      unidad_logica;
Type IRegistroFactura = Interface
  ['{A6A860E3-6C26-422A-A6E0-5FD441C86929}']
End;
Type TRegistroFactura = Class (TInterfacedObject,IRegistroFactura)
     Private
       FRegistroAlta:TRegistroAlta;
      // FRegistroAnulacion:TRegistroAnulacion
      // FEvento:Teventos
     Public
End;
implementation

end.
