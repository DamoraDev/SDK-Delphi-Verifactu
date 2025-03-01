unit clase_auditoria;

interface
uses sysutils,classes, jose.Core.JWT, jose.Core.JWS, jose.Core.JWK,
      FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef,
      FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
      FireDAC.DApt,FireDAC.Comp.DataSet;

type IAuditoria = interface
  ['{A05037D3-7F2B-4B33-BFB6-4A0FFCA2075B}']
end;
type Tauditoria = Class(TInterfacedObject, IAuditoria)
      Private
      Ftabladb:string;
      public
      class function Fallo(Alinea:integer;AClase:string;AExcepcion:string):string;
      class function Autotest:boolean;
      {
        Function FDConexionMYSQL(dbase:string;usuario:string;contrasena:string):TFDConnection;
        Function FDConexionSQLServer(dbase:string;usuario:string;contrasena:string):TFDConnection;
        Function FDConexionPosGreSQL(dbase:string;usuario:string;contrasena:string):TFDConnection;
        Function FDConexionMongoDB(dbase:string;usuario:string;contrasena:string):TFDConnection;
        Function FDConexionSQLite:TFDConnection;
        Function FDConexionMSAccess:TFDConnection;
        Procecdure FDSQLEnviarDatosStr (campo:string;dato:string;conexion:TFDConnection);
        Procecdure FDSQLEnviarDatosInt (campo:string;dato:integer;conexion:TFDConnection);
        Procecdure FDSQLEnviarDatosBool(campo:string;dato:boolean;conexion:TFDConnection);
		    Function TokenJWT(payload:TstringList):TJWT;
      }
End;

implementation
            {  funciones de la clase }
Class function TAuditoria.Autotest: Boolean;
Begin
   Result:=false;
   {
     generar Una factura con todos los casos posibles para verificar todas
     las clases, atendiendo al control de fallos ( errores ) de todas las clases.
     si hay una excepcion o un error el resultado debe ser FALSE, si todo esta bien
     el resultado debe de ser TRUE
   }
End;
Class function TAuditoria.Fallo(Alinea:integer;AClase:string;AExcepcion:string):string;
  Begin
     result:='Error :'+AExcepcion+' en linea '+IntToStr(Alinea)+' de la clase '+AClase;
  End;
end.
