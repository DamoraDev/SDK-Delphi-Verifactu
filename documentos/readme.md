![](verifactu%20SDK.png)

# 

**Versión del documento**: 0.1.0015

## Objetivo

El objetivo de este proyecto es proporcionar un **SDK OpenSource** para el sistema **Verifactu**, compatible con varios lenguajes de programación, con el propósito de facilitar la integración de sus funcionalidades en otros sistemas.

## Equipo de Desarrollo

- **David Morales**: Fundador y colaborador.
- **GPT-4** y **MsCopilot**: Asistencia en la optimización de código.

## Requisitos Necesarios

- **Embarcadero Delphi** (probado en la versión 11).
- **AutoFirma del Gobierno de España**.
- **LockBox 3**: RSA, SHA.
- **OverByte ICS / ICS SSL**: TSsIX509Certs.
- Conocimientos de **POO Delphi**, ya que el SDK está dividido en capas y clases.
- **Windows 8.1/10 64-bit** con procesador Core 2 Duo o QuadCore y 4-8 GB de RAM.
- **FreePascal**: No probado aún, pero se incluirá soporte en futuras versiones. Se planea ofrecer soporte como una DLL compatible con varios lenguajes de programación.

## Instalación y Uso

1. **Añadir el proyecto**: Coloca el contenido del proyecto en la carpeta donde deseas utilizarlo.
2. **Versión no compilada**: Si usas la versión no compilada, añade las carpetas del proyecto al **Search Path** de tu proyecto y agrega las unidades necesarias a tu código.
3. **Certificado Digital**: Asegúrate de tener un **certificado digital** (puedes utilizar uno de prueba descargado de fuentes oficiales como la Policía Nacional).
4. **Versión DLL**: Actualmente no disponible. Se planea portar el SDK a C# para ofrecer dos DLLs: una compilada en Delphi y otra en C#.
5. **Formulario de prueba**: El formulario de prueba incluye las unidades necesarias para utilizar el SDK.

La versión DLL se distribuirá junto con su **hash**, y se proporcionará una función para verificar el hash. Los hashes de cada versión homologada se documentarán en este archivo.

## Roadmap

- **Creación de Interfaces y clases para los nodos XML compatibles con el sistema Verifactu**: [En proceso].
- **Elaboración de la documentación necesaria para el uso del SDK**: [En proceso].
- **Test VCL de la estructura del XML Verifactu**: [En proceso].
- **Test de Huella Hash SHA256**: [En Proceso].
- **Test de firma digital del documento**: [Pendiente].
- **Registro de eventos**: [En proceso].
- **Test de envíos de facturas mediante servicio SOAP**: [Pendiente].
- **Implementar la gestión de eventos**: [Pendiente].
- **Añadir soporte ODBC y ADO con FireDac**: [Pendiente].
- **Convertir el SDK a DLL**: [Pendiente].
- **Clase TAuditoria :** Control de errores[ En proceso], autodiagnostico de todo el SDK, conexiones a bases de datos[*Sqlite, MongoDB,MySQL, SQLServer,PosgreSQL, MsAcces*] y generacion de token con payload de los datos para tablas o cluster de auditoria[pendiente]

## Versiones

- **Versión actual (Alpha)**: Actualmente en la versión **00.01.115**. Se está trabajando en el diseño de las interfaces y clases, y en su testeo. Una vez esté todo completo, se pasará a la fase Beta.
- **Versión Beta**: Generación de documentos con huella y firma.
- **Versión RC (Release Candidate)**: Envío de documentos completos atendiendo al encadenamiento, tipo de factura, rectificaciones, subsanaciones, anulaciones, etc.
- **Versión Final**: Resultados comprobados, con código optimizado por IA.
- **00.YY.ZZZ**:
  - **XX**: Versión final.
  - **YY**: Número de versión (par: estable, impar: con errores).
  - **ZZZ**: Correcciones de errores (ZZZ: número de revisiones).

## Distribución

- **SDK como código fuente**: No homologado, accesible para los desarrolladores que deseen trabajar directamente con el código.
- **SDK como DLL**: Homologado, junto con su hash y una unidad Delphi/FPC para verificar el hash.

## Licencia

Este proyecto se distribuye bajo la **Licencia MIT**:

Licencia MIT

Derechos de autor (c) [2025] [David Morales]

Por la presente se concede permiso, sin cargo, a cualquier persona que obtenga una copia de este software y de los archivos de documentación asociados (el "Software"), a utilizar el Software sin restricciones, incluidos, entre otros, los derechos a usar, copiar, modificar, fusionar, publicar, distribuir, sublicenciar y/o vender copias del Software, y a permitir a las personas a las que se les proporcione el Software a hacer lo mismo, sujeto a las siguientes condiciones: El aviso de derechos de autor anterior y este aviso de permiso se incluirán en todas las copias o partes sustanciales del Software. EL SOFTWARE SE PROPORCIONA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA, INCLUIDAS, PERO NO LIMITADAS A, LAS GARANTÍAS DE COMERCIABILIDAD, IDONEIDAD PARA UN PROPÓSITO PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS AUTORES O LOS TITULARES DE LOS DERECHOS DE AUTOR SERÁN RESPONSABLES DE NINGUNA RECLAMACIÓN, DAÑO O OTRA RESPONSABILIDAD, YA SEA EN UNA ACCIÓN CONTRACTUAL, AGRAVIO O DE OTRO TIPO, QUE SURJA DE, FUERA O EN CONEXIÓN CON EL SOFTWARE O EL USO U OTRO TIPO DE ACCIONES EN EL SOFTWARE.
