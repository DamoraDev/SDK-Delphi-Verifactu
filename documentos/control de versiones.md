### Estrategia para Versionado

1. **Versionado del API**:
   
   - Puedes seguir el esquema de **semver** (versionado semántico), que es común para APIs, lo que te ayudará a gestionar las versiones de tu API de manera consistente.
     - **Mayor** (`X`): Cambios incompatibles en la API (por ejemplo, eliminar o modificar funciones existentes).
     - **Menor** (`Y`): Nuevas funcionalidades que son retrocompatibles (por ejemplo, añadir nuevas clases o métodos sin afectar a los existentes).
     - **Patch** (`Z`): Corrección de errores, mejoras de rendimiento o pequeñas modificaciones sin alterar el comportamiento público de la API.
   
   Ejemplo de versionado:
   
   - **API v1.0.0**: Primera versión estable de la API.
   - **API v1.1.0**: Se añaden nuevas funcionalidades sin romper las anteriores.
   - **API v1.1.1**: Se corrige un error menor en la API.

2. **Versionado de Clases**:
   
   - Versionar cada clase individualmente es una excelente idea para tener un control más granular. Puedes hacerlo mediante el uso de un sufijo o un número de versión dentro de la clase.
   - Por ejemplo, si tienes una clase llamada `Factura`, la versión 1.0 de esta clase podría ser `Factura_v1` y, después de realizar cambios o mejoras, la versión 2.0 podría ser `Factura_v2`.
   - Al usar este enfoque, es más fácil determinar qué versión de cada clase está en uso sin tener que versionar todo el SDK o la API a la vez.
