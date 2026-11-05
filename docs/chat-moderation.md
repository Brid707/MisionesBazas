# Chat moderado de sala

Implementación local en `develop`; no publicada ni integrada a `main`.

## Comportamiento

El servidor aplica ambos catálogos es-MX/en-US siempre. Sustituye las coincidencias por `***`.
Un mensaje con groserías aporta un punto; con amenazas aporta tres, aunque incluya varias coincidencias
u otras groserías. Al alcanzar 15 puntos o más, tres mensajes con amenazas dentro del ciclo causan un
bloqueo permanente. Con menos amenazas: primer y segundo bloqueo de siete días; tercero permanente.
Los bloqueos temporales vencidos reinician puntos y amenazas al procesar el siguiente mensaje,
conservando la cantidad de bloqueos temporales previos.

El mensaje que activa el bloqueo no se publica. Se revocan las sesiones del usuario y se retira su
participación de las salas registradas por el servidor. Si es el anfitrión, la implementación existente
disuelve la sala. Los demás clientes reciben la notificación de salida o disolución.
Los invitados pueden leer el chat, pero solo las cuentas registradas pueden enviar mensajes.

## Preparación de la base de datos

El servidor utiliza la conexión Entity Framework existente `TrickTakingMissionsBDEntities`.
Antes de utilizar esta versión, ejecutar `Server/Persistence/Migrations/001_ChatModeration.sql` en la
base de datos de desarrollo correspondiente. El script agrega dos tablas, sin modificar el EDMX ni
las tablas existentes. No se ejecuta automáticamente al arrancar y no se ha aplicado a la base configurada.
La conexión LocalDB configurada no estuvo disponible durante la implementación.

La tabla de envíos utiliza un identificador por cuenta y un resumen SHA-256 del contenido y la sala;
no almacena el texto original. Una transacción con `sp_getapplock` exclusivo por cuenta serializa
la lectura, el registro del envío y la actualización de sanciones. Repetir el identificador con otro
contenido se rechaza. Reintentar el mismo envío no repite puntos ni publicación. No se garantiza
la entrega del mensaje a todos los clientes si el proceso termina después de confirmar la transacción.

## Catálogos y despliegue

`Server/Host/ModerationCatalogs/ProhibitedChatExpressions.es-MX.xml` y su equivalente en-US se copian
al directorio del servidor. El nuevo proyecto `Infrastructure.Moderation` los carga y valida al inicio.
Cada expresión incluye cultura, categoría y permiso de coincidencia con evasiones. Cambiar el catálogo
requiere revisar el contenido y reiniciar el servidor. No hay recarga automática.

Se normalizan mayúsculas, equivalencias Unicode, marcas combinantes y caracteres invisibles, conservando
los índices originales para la censura. Las reglas permiten repeticiones acotadas, separadores y ciertas
sustituciones. El catálogo es inicial y debe ampliarse con pruebas de vocabulario regional.
No interpreta de forma general negaciones, citas, ironía ni amenazas implícitas; una coincidencia literal
puede requerir ajustar la política para evitar falsos positivos. No se garantiza detectar todos los idiomas.

## Contratos y acceso

El envío WCF devuelve `LobbyChatMessageSubmissionOutcome`; las publicaciones y el bloqueo utilizan
callbacks unidireccionales. El cliente generado se obtiene del ensamblado del servidor con SvcUtil,
no mediante edición manual de `Reference.cs`. `Tools/UpdateGameServiceReference.ps1` reproduce ese paso.
Las referencias antiguas se conservan como archivos históricos pero ya no se compilan.

Los contratos activos del servidor usan el namespace `Services.DataContracts`, correspondiente a su carpeta.
Se regeneró el proxy y se actualizaron los namespaces de serialización del cliente de registro juntos.
Los archivos históricos excluidos de compilación conservan el nombre anterior `Services.DTO`.

El inicio de sesión devuelve un token aleatorio de 32 bytes, con vigencia de doce horas, que el cliente
adjunta a las operaciones de sala mediante un inspector WCF. El servidor verifica token, cuenta,
pertenencia y sanciones. No confía en el identificador de remitente enviado por el cliente.
Los tokens se conservan en memoria: reiniciar el servidor obliga a iniciar sesión nuevamente.
Cliente y servidor deben actualizarse juntos por el cambio del contrato; no hay compatibilidad con clientes anteriores.
Se mantienen las opciones de seguridad de transporte existentes; las pruebas locales usan un endpoint aislado.

## Verificación

Compilar `Server/Host/Host.csproj` y `Client/ClientTrickTakingMissions/View.csproj` con MSBuild de Visual Studio.
Compilar `Tests/ChatModeration/ChatModeration.Tests.csproj` y ejecutar su archivo de salida.
Las pruebas no requieren NuGet: su ejecutor devuelve código distinto de cero si falla alguna comprobación.
Incluyen reglas puras, censura bilingüe y comunicación WCF real con el proxy generado. Sustituyen solamente
los repositorios; no demuestran durabilidad, bloqueos ni recuperación de SQL Server.

La relación detallada con el estándar se registra en una página de Notion separada.
Los records del dominio requieren C# 9; se mantiene .NET Framework 4.7.2 mediante un marcador IsExternalInit.
No se actualizaron las dependencias de Entity Framework ni se descartaron cambios locales anteriores.

### Verificación tras integrar el registro de usuarios

Sobre develop, commit base `cf7638e`, el cliente compila y las 24 pruebas del chat aprueban.
El repositorio de pruebas implementa los nuevos miembros de `IUserRepository`; las operaciones de registro
no utilizadas fallan explícitamente con `NotSupportedException`, sin simular cuentas creadas.

Durante esa integración, la compilación normal del servidor quedó bloqueada por cinco fuentes de amistad referenciadas
en `Application.csproj` que aún no están disponibles. No se modificaron esas referencias ni esa funcionalidad.
Para comprobar el cambio de namespace se usó un archivo de targets temporal, fuera del repositorio,
que excluye solamente esas cinco entradas durante la compilación de verificación. Con esa exclusión
compilaron el servidor y las pruebas, y se generó el proxy desde los contratos compilados actuales.
Esta comprobación aislada no acredita la compilación completa de la funcionalidad de amistad.

Posteriormente, con autorización del usuario, se retiraron temporalmente las cinco entradas de compilación
de archivos de amistad ausentes en `Application.csproj`. No se borraron fuentes existentes ni se alteró
el módulo de amistad. La solución completa del servidor compila ahora sin exclusiones temporales externas,
y las 24 pruebas del chat aprueban. Las entradas deberán reincorporarse cuando estén disponibles los archivos.

### Vista de lobby

El chat se abre y se cierra mediante el botón inferior y se superpone al lobby sin reservar una fila permanente.
Las tarjetas muestran avatar, remitente y texto. El envío conserva su comando y admite el botón o Enter.
Se mantienen los avisos de moderación localizados. Los espacios vacantes se calculan con el límite real
de la sala; sus signos de suma son indicadores visuales, no acciones de invitación.

Se verificó el render WPF en español e inglés y la alternancia de visibilidad del panel con datos controlados.
El logo y la franja de cartas originales no están disponibles; permanece el título tipográfico.
La barra de amigos no se modificó. La vista no se presenta como una reproducción gráfica exacta.
