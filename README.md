# Switching - Sistema de Cambio de Comercializadora

## Descripción
Sistema de cambio de comercializadora para el mercado energético español. Permite gestionar los procesos de alta, baja y cambio de comercializadora para suministros de electricidad y gas natural.

## Funcionalidad Detallada

### Gestión de Suministros
El sistema permite gestionar todo el ciclo de vida de un suministro energético:
- **Registro de Suministros**: Creación y mantenimiento de suministros eléctricos y de gas
- **Validación de CUPS**: Verificación automática de la validez de los códigos CUPS
- **Gestión de Titularidad**: Control de cambios de titular y actualización de datos
- **Seguimiento de Estados**: Monitoreo del estado de cada suministro en tiempo real

### Procesos de Cambio
El sistema automatiza los siguientes procesos:

#### 1. Alta de Suministro
- Validación de datos del punto de suministro
- Verificación de disponibilidad del CUPS
- Generación de solicitud de alta
- Comunicación con la distribuidora
- Procesamiento de la respuesta
- Actualización del estado del suministro

#### 2. Baja de Suministro
- Verificación de titularidad actual
- Validación de condiciones para la baja
- Generación de solicitud de baja
- Confirmación con la distribuidora
- Actualización del estado final

#### 3. Cambio de Comercializadora
- Validación de condiciones del contrato actual
- Verificación de fechas de cambio
- Generación de solicitud de cambio
- Comunicación con ambas comercializadoras
- Confirmación del cambio efectivo

#### 4. Cambio de Titular
- Validación de documentación del nuevo titular
- Verificación de requisitos legales
- Generación de solicitud de cambio
- Procesamiento de la respuesta
- Actualización de datos del titular

### Integración con Distribuidoras
El sistema se comunica con las principales distribuidoras del mercado español:

#### Endesa
- Integración mediante API REST
- Autenticación mediante tokens
- Formato de mensajes XML personalizado
- Manejo específico de errores y validaciones

#### Iberdrola
- Comunicación mediante protocolo SOAP
- Validación de certificados digitales
- Formato de mensajes estandarizado
- Sistema de confirmaciones en dos pasos

#### Naturgy
- API REST con autenticación OAuth
- Formato de mensajes JSON
- Sistema de notificaciones push
- Manejo de estados intermedios

### Sistema de Notificaciones
- Notificaciones automáticas por email
- Alertas de estado en tiempo real
- Registro detallado de eventos
- Sistema de notificaciones push para cambios críticos

### Manejo de Errores
- Sistema de reintentos automático
- Registro detallado de errores
- Clasificación de errores por tipo
- Notificaciones de error personalizadas
- Recuperación automática de procesos

### Reportes y Analytics
- Dashboard de seguimiento
- Reportes de actividad
- Análisis de tiempos de proceso
- Métricas de éxito/fracaso
- Predicción de tiempos de respuesta

## Estructura del Proyecto

### Objetos Personalizados

#### Service__c
Objeto principal que representa un suministro energético.
- **Campos principales**:
  - `AccountId__c`: Referencia a la cuenta
  - `CUPS__c`: Código Universal del Punto de Suministro
  - `CUPS_Electricidad__c`: CUPS específico para electricidad
  - `CUPS_Gas__c`: CUPS específico para gas
  - `Contract__c`: Referencia al contrato
  - `Country__c`: País del suministro
  - `Distributor__c`: Distribuidora
  - `Effective_Date__c`: Fecha efectiva del cambio
  - `Energy_Type__c`: Tipo de energía (Electricidad/Gas)
  - `Holder_NIF__c`: NIF del titular
  - `Holder_Name__c`: Nombre del titular
  - `New_Holder_NIF__c`: NIF del nuevo titular
  - `New_Holder_Name__c`: Nombre del nuevo titular
  - `New_Supplier__c`: Nueva comercializadora
  - `Status__c`: Estado del suministro
  - `Type__c`: Tipo de proceso

#### Switching_Request__c
Gestiona las solicitudes de cambio.
- **Campos principales**:
  - `CUPS__c`: Código CUPS
  - `Configuration__c`: Configuración asociada
  - `Contract__c`: Contrato relacionado
  - `Country__c`: País
  - `Distributor__c`: Distribuidora
  - `Effective_Date__c`: Fecha efectiva
  - `Process_Type__c`: Tipo de proceso
  - `Request_Date__c`: Fecha de solicitud
  - `Response_Date__c`: Fecha de respuesta
  - `Status__c`: Estado de la solicitud
  - `Type__c`: Tipo de solicitud

#### Switching_Message__c
Registra los mensajes intercambiados con las distribuidoras.
- **Campos principales**:
  - `Account__c`: Cuenta asociada
  - `CUPS__c`: Código CUPS
  - `Distributor__c`: Distribuidora
  - `Message_Content__c`: Contenido del mensaje
  - `Message_Type__c`: Tipo de mensaje
  - `Request_XML__c`: XML de solicitud
  - `Response_XML__c`: XML de respuesta
  - `Status__c`: Estado del mensaje

#### Switching_Configuration__c
Configuración de integración con distribuidoras.
- **Campos principales**:
  - `API_Key__c`: Clave API
  - `Active__c`: Estado activo
  - `Country__c`: País
  - `Distributor__c`: Distribuidora
  - `Endpoint_URL__c`: URL del endpoint
  - `Integration_Class__c`: Clase de integración
  - `Message_Format__c`: Formato de mensaje
  - `Process_Type__c`: Tipo de proceso
  - `Template__c`: Plantilla

#### XML_Template__c
Plantillas XML para las comunicaciones.
- **Campos principales**:
  - `Active__c`: Estado activo
  - `CodigoProceso__c`: Código de proceso
  - `Country__c`: País
  - `Distributor__c`: Distribuidora
  - `Process_Type__c`: Tipo de proceso
  - `Template_Body__c`: Cuerpo de la plantilla
  - `Template_Content__c`: Contenido de la plantilla
  - `Version__c`: Versión

### Objetos de Configuración

#### Switching_Configuration__c
Objeto principal de configuración del sistema.
- **Campos principales**:
  - `API_Key__c`: Clave API para autenticación
  - `Active__c`: Indica si la configuración está activa
  - `Country__c`: País de la configuración
  - `Distributor__c`: Distribuidora asociada
  - `Endpoint_URL__c`: URL del endpoint de la API
  - `Integration_Class__c`: Clase Apex de integración
  - `Message_Format__c`: Formato de mensaje (XML/JSON)
  - `Process_Type__c`: Tipo de proceso configurado
  - `Template__c`: Plantilla asociada
  - `Timeout__c`: Tiempo de espera en segundos

#### XML_Template__c
Configuración de plantillas XML para las comunicaciones.
- **Campos principales**:
  - `Active__c`: Indica si la plantilla está activa
  - `CodigoProceso__c`: Código del proceso
  - `Country__c`: País de la plantilla
  - `Distributor__c`: Distribuidora asociada
  - `Process_Type__c`: Tipo de proceso
  - `Template_Body__c`: Cuerpo de la plantilla
  - `Template_Content__c`: Contenido de la plantilla
  - `Version__c`: Versión de la plantilla
  - `Validation_Rules__c`: Reglas de validación
  - `Required_Fields__c`: Campos obligatorios

#### Switching_Notification__c
Configuración de notificaciones del sistema.
- **Campos principales**:
  - `Active__c`: Indica si la configuración está activa
  - `Notification_Type__c`: Tipo de notificación
  - `Email_Template__c`: Plantilla de email
  - `Recipients__c`: Destinatarios
  - `Trigger_Events__c`: Eventos que activan la notificación
  - `Conditions__c`: Condiciones para enviar la notificación
  - `Priority__c`: Prioridad de la notificación

#### Switching_Retry_Config__c
Configuración de reintentos automáticos.
- **Campos principales**:
  - `Active__c`: Indica si la configuración está activa
  - `Process_Type__c`: Tipo de proceso
  - `Max_Retries__c`: Número máximo de reintentos
  - `Retry_Interval__c`: Intervalo entre reintentos
  - `Error_Types__c`: Tipos de error que activan el reintento
  - `Conditions__c`: Condiciones para el reintento
  - `Notification_Config__c`: Configuración de notificación para reintentos

#### Switching_Validation_Rules__c
Reglas de validación para los procesos.
- **Campos principales**:
  - `Active__c`: Indica si la regla está activa
  - `Process_Type__c`: Tipo de proceso
  - `Field_Name__c`: Campo a validar
  - `Validation_Type__c`: Tipo de validación
  - `Validation_Rule__c`: Regla de validación
  - `Error_Message__c`: Mensaje de error
  - `Severity__c`: Severidad del error

### Diagrama de Configuración
```mermaid
graph TD
    A[Switching_Configuration__c] --> B[XML_Template__c]
    A --> C[Switching_Notification__c]
    A --> D[Switching_Retry_Config__c]
    A --> E[Switching_Validation_Rules__c]
    
    B --> F[Plantillas XML]
    C --> G[Notificaciones]
    D --> H[Reintentos]
    E --> I[Validaciones]
    
    F --> J[Procesos]
    G --> J
    H --> J
    I --> J
```

### Clases Apex

#### Clases Base
- `BaseDistributorIntegration`: Clase base para integraciones
- `BaseSwitchingProcess`: Clase base para procesos de cambio
- `IDistributorIntegration`: Interfaz para integraciones

#### Procesos de Cambio
- `ElecAltaProcess`: Proceso de alta eléctrica
- `ElecBajaProcess`: Proceso de baja eléctrica
- `ElecCambioComercializadoraProcess`: Cambio de comercializadora eléctrica
- `ElecCambioTitularProcess`: Cambio de titular eléctrico
- `GasBajaProcess`: Proceso de baja de gas
- `GasCambioComercializadoraProcess`: Cambio de comercializadora de gas
- `GasCambioTitularProcess`: Cambio de titular de gas

#### Integraciones
- `EndesaIntegration`: Integración con Endesa
- `IberdrolaIntegration`: Integración con Iberdrola
- `NaturgyIntegration`: Integración con Naturgy

#### Utilidades
- `MessageGenerator`: Generador de mensajes
- `SwitchingErrorHandler`: Manejador de errores
- `SwitchingEventHandler`: Manejador de eventos
- `SwitchingRetryHandler`: Manejador de reintentos
- `SwitchingRetryScheduler`: Programador de reintentos
- `XMLTemplateManager`: Gestor de plantillas XML

### Métodos Principales

#### Switching_Service
Clase principal que orquesta los procesos de switching.

```apex
// Métodos principales
public static void iniciarProcesoAlta(Id serviceId)
public static void iniciarProcesoBaja(Id serviceId)
public static void iniciarProcesoCambioComercializadora(Id serviceId)
public static void iniciarProcesoCambioTitular(Id serviceId)
public static void procesarSolicitud(Id requestId)
public static void actualizarEstado(Id serviceId, String nuevoEstado)
```

#### BaseDistributorIntegration
Clase base para las integraciones con distribuidoras.

```apex
// Métodos principales
public virtual void enviarSolicitud(Switching_Request__c request)
public virtual void procesarRespuesta(Switching_Message__c message)
public virtual void validarDatos(Switching_Request__c request)
public virtual void manejarError(Switching_Message__c message)
```

#### SwitchingErrorHandler
Manejador de errores del sistema.

```apex
// Métodos principales
public static void registrarError(Exception e)
public static Boolean esReintentable(Exception e)
public static void notificarError(Id requestId, String mensaje)
public static void clasificarError(Exception e)
```

#### XMLTemplateManager
Gestor de plantillas XML.

```apex
// Métodos principales
public static String generarXML(String templateName, Map<String, Object> params)
public static void validarXML(String xml)
public static String procesarRespuestaXML(String xml)
public static void guardarPlantilla(XML_Template__c template)
```

#### SwitchingRetryHandler
Manejador de reintentos.

```apex
// Métodos principales
public static void programarReintento(Id requestId)
public static void ejecutarReintento(Id requestId)
public static Integer obtenerNumeroReintentos(Id requestId)
public static void cancelarReintentos(Id requestId)
```

#### MessageGenerator
Generador de mensajes para las distribuidoras.

```apex
// Métodos principales
public static Switching_Message__c crearMensaje(Id requestId, String tipo)
public static void actualizarMensaje(Switching_Message__c message)
public static void procesarRespuesta(Switching_Message__c message)
public static void registrarError(Switching_Message__c message, String error)
```

#### SwitchingEventHandler
Manejador de eventos del sistema.

```apex
// Métodos principales
public static void registrarEvento(Id serviceId, String tipo, String mensaje)
public static void notificarCambioEstado(Id serviceId, String estadoAnterior, String estadoNuevo)
public static void registrarComunicacion(Id messageId, String tipo)
```

### Diagrama de Clases
```mermaid
classDiagram
    class Switching_Service {
        +iniciarProcesoAlta(Id)
        +iniciarProcesoBaja(Id)
        +iniciarProcesoCambioComercializadora(Id)
        +iniciarProcesoCambioTitular(Id)
        +procesarSolicitud(Id)
        +actualizarEstado(Id, String)
    }
    
    class BaseDistributorIntegration {
        <<abstract>>
        +enviarSolicitud(Switching_Request__c)
        +procesarRespuesta(Switching_Message__c)
        +validarDatos(Switching_Request__c)
        +manejarError(Switching_Message__c)
    }
    
    class EndesaIntegration {
        +enviarSolicitud(Switching_Request__c)
        +procesarRespuesta(Switching_Message__c)
    }
    
    class IberdrolaIntegration {
        +enviarSolicitud(Switching_Request__c)
        +procesarRespuesta(Switching_Message__c)
    }
    
    class NaturgyIntegration {
        +enviarSolicitud(Switching_Request__c)
        +procesarRespuesta(Switching_Message__c)
    }
    
    class SwitchingErrorHandler {
        +registrarError(Exception)
        +esReintentable(Exception)
        +notificarError(Id, String)
        +clasificarError(Exception)
    }
    
    class XMLTemplateManager {
        +generarXML(String, Map<String, Object>)
        +validarXML(String)
        +procesarRespuestaXML(String)
        +guardarPlantilla(XML_Template__c)
    }
    
    Switching_Service --> BaseDistributorIntegration
    BaseDistributorIntegration <|-- EndesaIntegration
    BaseDistributorIntegration <|-- IberdrolaIntegration
    BaseDistributorIntegration <|-- NaturgyIntegration
    Switching_Service --> SwitchingErrorHandler
    Switching_Service --> XMLTemplateManager
```

### Triggers y Flows

#### Triggers

##### SwitchingRequestTrigger
Trigger principal que maneja los eventos de las solicitudes de cambio.
- **Eventos manejados**:
  - `after insert`: Procesa nuevas solicitudes
  - `after update`: Maneja cambios de estado en solicitudes existentes
- **Funcionalidad**:
  - Inicia el proceso de switching cuando se crea una nueva solicitud
  - Actualiza el estado del suministro cuando cambia el estado de la solicitud
  - Genera notificaciones de cambio de estado
  - Registra eventos en el historial de mensajes

##### SwitchingMessageTrigger
Maneja los eventos relacionados con los mensajes intercambiados con las distribuidoras.
- **Eventos manejados**:
  - `after insert`: Procesa nuevos mensajes
  - `after update`: Actualiza el estado de los mensajes
- **Funcionalidad**:
  - Actualiza el estado de las solicitudes relacionadas
  - Genera notificaciones de recepción de mensajes
  - Registra eventos de comunicación

#### Flows

##### Process_Switching_Request
Flow principal que orquesta el proceso de switching.
- **Elementos principales**:
  - **Screen**: Interfaz de usuario para iniciar el proceso
  - **Decision**: Valida los datos de entrada
  - **Assignment**: Asigna valores a variables
  - **Subflow**: Llama a procesos específicos
  - **Action**: Ejecuta acciones en el sistema
- **Funcionalidad**:
  - Recoge datos del usuario
  - Valida la información proporcionada
  - Determina el tipo de proceso a ejecutar
  - Inicia el proceso correspondiente
  - Maneja errores y excepciones
  - Proporciona feedback al usuario

##### Switching_Notification_Flow
Maneja las notificaciones del sistema.
- **Elementos principales**:
  - **Decision**: Determina el tipo de notificación
  - **Action**: Envía emails o notificaciones
  - **Assignment**: Prepara el contenido de las notificaciones
- **Funcionalidad**:
  - Genera notificaciones de estado
  - Envía alertas de error
  - Proporciona confirmaciones de acción
  - Mantiene un registro de notificaciones enviadas

##### Switching_Error_Handler_Flow
Maneja los errores del sistema.
- **Elementos principales**:
  - **Decision**: Clasifica el tipo de error
  - **Action**: Ejecuta acciones de recuperación
  - **Assignment**: Prepara información de error
- **Funcionalidad**:
  - Clasifica errores por tipo
  - Determina si el error es reintentable
  - Inicia procesos de recuperación
  - Notifica a los usuarios afectados
  - Registra información de error para análisis

### Permission Sets
- `Switching_Admin`: Permisos de administración

## Procesos Implementados

### 1. Alta de Suministro Eléctrico
- Validación de datos del CUPS
- Generación de solicitud XML
- Envío a distribuidora
- Procesamiento de respuesta

### 2. Baja de Suministro
- Verificación de titularidad
- Generación de solicitud
- Confirmación de baja
- Actualización de estado

### 3. Cambio de Comercializadora
- Validación de condiciones
- Generación de solicitud
- Comunicación con distribuidora
- Confirmación del cambio

### 4. Cambio de Titular
- Verificación de documentación
- Generación de solicitud
- Procesamiento de respuesta
- Actualización de datos

## Diagramas de Procesos

### Flujo General del Sistema
```mermaid
graph TD
    A[Inicio] --> B[Crear Solicitud]
    B --> C{Validar Datos}
    C -->|Válido| D[Generar XML]
    C -->|Inválido| E[Notificar Error]
    D --> F[Enviar a Distribuidora]
    F --> G{Procesar Respuesta}
    G -->|Éxito| H[Actualizar Estado]
    G -->|Error| I[Manejar Error]
    I --> J{Reintentar?}
    J -->|Sí| F
    J -->|No| K[Notificar Error Final]
    H --> L[Fin]
```

### Proceso de Alta
```mermaid
sequenceDiagram
    participant U as Usuario
    participant S as Sistema
    participant D as Distribuidora
    
    U->>S: Iniciar Alta
    S->>S: Validar CUPS
    S->>S: Generar XML
    S->>D: Enviar Solicitud
    D->>S: Respuesta
    alt Éxito
        S->>S: Crear Suministro
        S->>U: Confirmar Alta
    else Error
        S->>S: Registrar Error
        S->>U: Notificar Error
    end
```

### Proceso de Baja
```mermaid
stateDiagram-v2
    [*] --> Pendiente
    Pendiente --> Validación
    Validación --> GeneraciónXML
    GeneraciónXML --> EnvíoDistribuidora
    EnvíoDistribuidora --> Procesamiento
    Procesamiento --> Confirmada
    Procesamiento --> Error
    Error --> Reintento
    Reintento --> EnvíoDistribuidora
    Reintento --> ErrorFinal
    Confirmada --> [*]
    ErrorFinal --> [*]
```

### Integración con Distribuidoras
```mermaid
graph LR
    A[Sistema] --> B[Factory]
    B --> C[Endesa]
    B --> D[Iberdrola]
    B --> E[Naturgy]
    
    C --> F[XML]
    D --> G[SOAP]
    E --> H[REST]
    
    F --> I[Respuesta]
    G --> I
    H --> I
```

### Manejo de Errores
```mermaid
graph TD
    A[Error] --> B{Es Reintentable?}
    B -->|Sí| C[Programar Reintento]
    B -->|No| D[Notificar Error]
    C --> E[Esperar Tiempo]
    E --> F[Reintentar]
    F --> G{Éxito?}
    G -->|Sí| H[Continuar]
    G -->|No| I{Max Reintentos?}
    I -->|Sí| D
    I -->|No| C
```

## Diagramas Técnicos

#### Arquitectura del Sistema
```mermaid
graph TD
    subgraph Frontend
        A[Lightning Pages] --> B[Flows]
        B --> C[Triggers]
    end
    
    subgraph Backend
        C --> D[Clases Apex]
        D --> E[Integraciones]
    end
    
    subgraph Base de Datos
        F[Objetos Personalizados]
        G[Configuraciones]
    end
    
    E --> F
    E --> G
```

#### Flujo de Datos en Alta de Suministro
```mermaid
sequenceDiagram
    participant UI as Interfaz Usuario
    participant Flow as Process_Switching_Request
    participant Trigger as SwitchingRequestTrigger
    participant Service as Switching_Service
    participant Integration as DistributorIntegration
    participant DB as Base de Datos
    
    UI->>Flow: Iniciar Alta
    Flow->>DB: Crear Service__c
    DB->>Trigger: after insert
    Trigger->>Service: iniciarProcesoAlta()
    Service->>Integration: enviarSolicitud()
    Integration->>DB: Registrar Switching_Message__c
    DB->>Trigger: after insert
    Trigger->>Service: procesarRespuesta()
    Service->>DB: Actualizar Service__c
```

#### Interacción de Triggers
```mermaid
graph TD
    A[SwitchingRequestTrigger] --> B[Crear Solicitud]
    B --> C[Iniciar Proceso]
    C --> D[Actualizar Estado]
    
    E[SwitchingMessageTrigger] --> F[Procesar Mensaje]
    F --> G[Actualizar Solicitud]
    G --> H[Generar Notificación]
    
    D --> I[Base de Datos]
    H --> I
```

#### Flows y sus Componentes
```mermaid
graph LR
    A[Process_Switching_Request] --> B[Screen]
    A --> C[Decision]
    A --> D[Assignment]
    A --> E[Subflow]
    A --> F[Action]
    
    B --> G[Validación]
    C --> H[Lógica]
    D --> I[Variables]
    E --> J[Procesos]
    F --> K[Acciones]
```

#### Manejo de Errores
```mermaid
graph TD
    A[Error] --> B[SwitchingErrorHandler]
    B --> C{Clasificar Error}
    C -->|Temporal| D[SwitchingRetryHandler]
    C -->|Permanente| E[SwitchingNotification]
    
    D --> F[SwitchingRetryScheduler]
    F --> G[Programar Reintento]
    G --> H[Base de Datos]
    
    E --> I[Notificar Usuario]
    I --> H
```

#### Integración con Distribuidoras
```mermaid
graph TD
    A[Switching_Service] --> B[DistributorIntegrationFactory]
    B --> C[EndesaIntegration]
    B --> D[IberdrolaIntegration]
    B --> E[NaturgyIntegration]
    
    C --> F[XMLTemplateManager]
    D --> F
    E --> F
    
    F --> G[Base de Datos]
    C --> H[API Endesa]
    D --> I[API Iberdrola]
    E --> J[API Naturgy]
```

## Diagramas de Llamadas a Métodos

#### Proceso de Alta de Suministro
```mermaid
sequenceDiagram
    participant UI as Interfaz Usuario
    participant Flow as Process_Switching_Request
    participant Trigger as SwitchingRequestTrigger
    participant Service as Switching_Service
    participant Integration as BaseDistributorIntegration
    participant Template as XMLTemplateManager
    participant Error as SwitchingErrorHandler
    participant Event as SwitchingEventHandler
    
    UI->>Flow: Iniciar Alta
    Flow->>Service: iniciarProcesoAlta(serviceId)
    Service->>Integration: validarDatos(request)
    Integration->>Template: generarXML('B1', params)
    Template->>Integration: return xml
    Integration->>Service: enviarSolicitud(request)
    Service->>Event: registrarEvento(serviceId, 'ALTA_INICIADA')
    
    alt Error en validación
        Integration->>Error: registrarError(exception)
        Error->>Service: return false
        Service->>Event: registrarEvento(serviceId, 'ERROR_VALIDACION')
    else Validación exitosa
        Integration->>Service: return true
        Service->>Event: registrarEvento(serviceId, 'ALTA_ENVIADA')
    end
```

#### Proceso de Cambio de Comercializadora
```mermaid
sequenceDiagram
    participant UI as Interfaz Usuario
    participant Flow as Process_Switching_Request
    participant Service as Switching_Service
    participant Integration as BaseDistributorIntegration
    participant Template as XMLTemplateManager
    participant Retry as SwitchingRetryHandler
    participant Event as SwitchingEventHandler
    
    UI->>Flow: Iniciar Cambio
    Flow->>Service: iniciarProcesoCambioComercializadora(serviceId)
    Service->>Integration: validarDatos(request)
    Integration->>Template: generarXML('C1', params)
    Template->>Integration: return xml
    Integration->>Service: enviarSolicitud(request)
    
    loop Reintentos si es necesario
        alt Error en envío
            Service->>Retry: programarReintento(requestId)
            Retry->>Service: return true
            Service->>Event: registrarEvento(serviceId, 'REINTENTO_PROGRAMADO')
        else Éxito
            Service->>Event: registrarEvento(serviceId, 'CAMBIO_ENVIADO')
        end
    end
```

#### Manejo de Errores y Reintentos
```mermaid
sequenceDiagram
    participant Service as Switching_Service
    participant Error as SwitchingErrorHandler
    participant Retry as SwitchingRetryHandler
    participant Scheduler as SwitchingRetryScheduler
    participant Event as SwitchingEventHandler
    
    Service->>Error: registrarError(exception)
    Error->>Error: clasificarError(exception)
    
    alt Error es reintentable
        Error->>Retry: programarReintento(requestId)
        Retry->>Scheduler: programarReintento(requestId)
        Scheduler->>Event: registrarEvento(serviceId, 'REINTENTO_PROGRAMADO')
    else Error no reintentable
        Error->>Event: registrarEvento(serviceId, 'ERROR_FINAL')
    end
```

#### Proceso de Notificaciones
```mermaid
sequenceDiagram
    participant Service as Switching_Service
    participant Event as SwitchingEventHandler
    participant Message as MessageGenerator
    participant Flow as Switching_Notification_Flow
    
    Service->>Event: registrarEvento(serviceId, 'ESTADO_CAMBIADO')
    Event->>Message: crearMensaje(requestId, 'NOTIFICACION')
    Message->>Flow: iniciarNotificacion(messageId)
    Flow->>Flow: prepararContenido()
    Flow->>Flow: enviarNotificacion()
    Flow->>Event: registrarEvento(serviceId, 'NOTIFICACION_ENVIADA')
```

#### Integración con Distribuidora
```mermaid
sequenceDiagram
    participant Service as Switching_Service
    participant Factory as DistributorIntegrationFactory
    participant Integration as BaseDistributorIntegration
    participant Template as XMLTemplateManager
    participant Message as MessageGenerator
    
    Service->>Factory: getIntegration(distributor)
    Factory->>Service: return Integration
    Service->>Integration: validarDatos(request)
    Integration->>Template: generarXML(templateName, params)
    Template->>Integration: return xml
    Integration->>Message: crearMensaje(requestId, 'SOLICITUD')
    Message->>Integration: return message
    Integration->>Service: enviarSolicitud(request)
```

## Integración con Distribuidoras

### Endesa
- Endpoint específico
- Formato XML personalizado
- Manejo de autenticación

### Iberdrola
- Protocolo SOAP
- Validación de certificados
- Gestión de errores

### Naturgy
- API REST
- Autenticación OAuth
- Formato JSON

## Manejo de Errores
- Sistema de reintentos automático
- Notificaciones de error
- Registro detallado de fallos
- Recuperación de procesos

## Seguridad
- Permisos por perfil
- Validación de datos
- Encriptación de información sensible
- Registro de auditoría

## Próximos Pasos
1. Implementar integración con más distribuidoras
2. Mejorar sistema de reintentos
3. Optimizar procesamiento de XML
4. Añadir más tipos de procesos
5. Implementar notificaciones push

## Contacto
Para soporte técnico o consultas, contactar con el equipo de desarrollo.

## Ejemplos Prácticos

### 1. Configuración del Sistema
```apex
// 1. Crear cuenta y distribuidor
Account distribuidor = new Account(
    Name = 'ENDESA',
    RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distribuidor').getRecordTypeId()
);
insert distribuidor;

Account cliente = new Account(
    Name = 'Juan Pérez',
    BillingCountry = 'ES',
    RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId()
);
insert cliente;

// 2. Crear un nuevo suministro eléctrico
Service__c nuevoSuministro = new Service__c(
    Name = 'ES1234000000000000JN',
    CUPS_Electricidad__c = 'ES1234000000000000JN',
    Energy_Type__c = 'Electricidad',
    Distributor__c = distribuidor.Id,
    Holder_NIF__c = '12345678A',
    Holder_Name__c = 'Juan Pérez',
    Effective_Date__c = Date.today().addDays(15),
    Status__c = 'Pendiente',
    Account__c = cliente.Id
);
insert nuevoSuministro;

// 3. Crear la solicitud de alta
Switching_Request__c solicitud = new Switching_Request__c(
    Service__c = nuevoSuministro.Id,
    Process_Type__c = 'ALTA_GAS',
    Status__c = 'Draft',
    Request_Date__c = Datetime.now(),
    Distributor__c = distribuidor.Id,
    Country__c = 'ES'
);
insert solicitud;

// 4. Configurar integración con Endesa
Switching_Configuration__c configEndesa = new Switching_Configuration__c(
    Name = 'Config_Endesa',
    Distributor__c = distribuidor.Id,
    Process_Type__c = 'ALTA_GAS',
    Active__c = true,
    Integration_Class__c = 'EndesaIntegration',
    Message_Format__c = 'XML',
    Country__c = 'ES',
    Endpoint_URL__c = 'https://api.endesa.com/v1/switching',
    API_Key__c = 'tu-api-key',
    Username__c = 'endesa_user',
    Password__c = 'password123',
    Status__c = 'PENDING',
    Timeout__c = 30000
);
insert configEndesa;
```

### 2. Alta de Suministro Eléctrico
```apex
// Crear una cuenta para el cliente
Account cliente = new Account(
    Name = 'Juan Pérez',
    BillingCountry = 'ES',
    RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId()
);
insert cliente;

// Obtener el distribuidor
Account dist = [SELECT Id FROM Account WHERE RecordType.DeveloperName = 'Distribuidor' AND Name = 'ENDESA' LIMIT 1];

// Crear un nuevo suministro eléctrico
Service__c nuevoSuministro = new Service__c(
    Name = 'ES1234000000000000JN',
    CUPS_Electricidad__c = 'ES1234000000000000JN',
    Energy_Type__c = 'Electricity',
    Distributor__c = dist.Id,
    Holder_NIF__c = '12345678A',
    Holder_Name__c = 'Juan Pérez',
    Effective_Date__c = Date.today().addDays(15),
    Status__c = 'Pendiente',
    Account__c = cliente.Id,
    Type__c = 'Electricity',
    Country__c = 'ES'
);
insert nuevoSuministro;

// Crear la solicitud de alta
Switching_Request__c solicitud = new Switching_Request__c(
    Service__c = nuevoSuministro.Id,
    Process_Type__c = 'ALTA_GAS',
    Status__c = 'Draft',
    Distributor__c = dist.Id,
    Country__c = 'ES',
    Request_Date__c = Datetime.now()
);
insert solicitud;

// Iniciar el proceso de alta
ElecAltaProcess proceso = new ElecAltaProcess(solicitud);
proceso.execute();
```

### 3. Cambio de Comercializadora
```apex
// Obtener el suministro existente y el distribuidor
Service__c suministro = [SELECT Id, CUPS_Electricidad__c, Distributor__c 
                        FROM Service__c 
                        WHERE CUPS_Electricidad__c = 'ES1234000000000000JN' 
                        LIMIT 1];

Account dist = [SELECT Id FROM Account WHERE Id = :suministro.Distributor__c];

// Crear la solicitud de cambio
Switching_Request__c solicitud = new Switching_Request__c(
    Service__c = suministro.Id,
    Process_Type__c = 'CAMBIO_COMERCIALIZADORA',
    Status__c = 'Draft',
    Distributor__c = dist.Id,
    Country__c = 'ES',
    Request_Date__c = Datetime.now(),
    Effective_Date__c = Date.today().addDays(30)
);
insert solicitud;

// Iniciar el proceso de cambio
ElecCambioComercializadoraProcess proceso = new ElecCambioComercializadoraProcess(solicitud);
proceso.execute();
```

### 4. Cambio de Titular
```apex
// Obtener el suministro existente y el distribuidor
Service__c suministro = [SELECT Id, CUPS_Electricidad__c, Distributor__c 
                        FROM Service__c 
                        WHERE CUPS_Electricidad__c = 'ES1234000000000000JN' 
                        LIMIT 1];

Account dist = [SELECT Id FROM Account WHERE Id = :suministro.Distributor__c];

// Crear la solicitud de cambio de titular
Switching_Request__c solicitud = new Switching_Request__c(
    Service__c = suministro.Id,
    Process_Type__c = 'CAMBIO_TITULAR',
    Status__c = 'Draft',
    Distributor__c = dist.Id,
    Country__c = 'ES',
    Request_Date__c = Datetime.now(),
    New_Holder_NIF__c = '87654321B',
    New_Holder_Name__c = 'María García'
);
insert solicitud;

// Iniciar el proceso de cambio de titular
ElecCambioTitularProcess proceso = new ElecCambioTitularProcess(solicitud);
proceso.execute();
```

### 5. Consulta de Estado
```apex
// Obtener el estado actual de una solicitud
Switching_Request__c solicitud = [
    SELECT Id, Status__c, Error_Message__c,
           (SELECT Id, Type__c, Message__c, Status__c
            FROM Switching_Notifications__r
            ORDER BY CreatedDate DESC
            LIMIT 1)
    FROM Switching_Request__c
    WHERE Service__c = :suministro.Id
    ORDER BY CreatedDate DESC
    LIMIT 1
];

System.debug('Estado actual: ' + solicitud.Status__c);
if (solicitud.Error_Message__c != null) {
    System.debug('Error: ' + solicitud.Error_Message__c);
}
if (!solicitud.Switching_Notifications__r.isEmpty()) {
    System.debug('Última notificación: ' + solicitud.Switching_Notifications__r[0].Type__c);
    System.debug('Mensaje: ' + solicitud.Switching_Notifications__r[0].Message__c);
}
```

### 6. Configuración de Integración
```apex
// Obtener el distribuidor
Account dist = [SELECT Id FROM Account WHERE RecordType.DeveloperName = 'Distribuidor' AND Name = 'ENDESA' LIMIT 1];

// Configurar integración con Endesa
Switching_Configuration__c configEndesa = new Switching_Configuration__c(
    Name = 'Config_Endesa',
    Distributor__c = dist.Id,
    Process_Type__c = 'ALTA_GAS',
    Active__c = true,
    Integration_Class__c = 'EndesaIntegration',
    Message_Format__c = 'XML',
    Country__c = 'ES',
    Endpoint_URL__c = 'https://api.endesa.com/v1/switching',
    API_Key__c = 'tu-api-key',
    Username__c = 'endesa_user',
    Password__c = 'password123',
    Status__c = 'PENDING',
    Timeout__c = 30000
);
insert configEndesa;
```

### 7. Plantilla XML Personalizada
```apex
// Obtener el distribuidor
Account dist = [SELECT Id FROM Account WHERE RecordType.DeveloperName = 'Distribuidor' AND Name = 'ENDESA' LIMIT 1];

// Crear una plantilla XML para alta eléctrica
XML_Template__c plantilla = new XML_Template__c(
    Name = 'Alta_Electrica_Endesa',
    Distributor__c = dist.Id,
    Process_Type__c = 'ACTIVATION',
    CNMC_Process_Type__c = 'C1',
    Active__c = true,
    Template_Body__c = '<?xml version="1.0"?><solicitud><cups>{CUPS}</cups><titular><nif>{NIF}</nif><nombre>{NOMBRE}</nombre></titular></solicitud>',
    Version__c = 1.0,
    Process_Code__c = 'ALTA_ELEC',
    CodigoProceso__c = 'ALTA_ELEC'
);
insert plantilla;
```

### 8. Manejo de Errores
```apex
try {
    // Obtener la solicitud y el distribuidor
    Switching_Request__c solicitud = [
        SELECT Id, Status__c, Distributor__c 
        FROM Switching_Request__c 
        WHERE Id = :solicitudId
    ];
    
    Account dist = [SELECT Id FROM Account WHERE Id = :solicitud.Distributor__c];
    
    // Procesar la solicitud
    ElecAltaProcess proceso = new ElecAltaProcess(solicitud);
    proceso.execute();
    
} catch (Exception e) {
    // Crear notificación de error
    Switching_Notification__c notif = new Switching_Notification__c(
        Request__c = solicitudId,
        Type__c = 'Error',
        Status__c = 'Error',
        Message__c = e.getMessage()
    );
    insert notif;
    
    // Obtener la configuración
    Switching_Configuration__c config = [
        SELECT Id, Timeout__c 
        FROM Switching_Configuration__c 
        WHERE Distributor__c = :dist.Id
        AND Process_Type__c = 'ALTA_GAS'
        AND Active__c = true
        LIMIT 1
    ];
}
```

### 9. Consulta de Historial
```apex
// Obtener historial de notificaciones para un suministro
List<Switching_Notification__c> historial = [
    SELECT Id, Type__c, Status__c, Message__c, CreatedDate,
           Request__r.Process_Type__c
    FROM Switching_Notification__c
    WHERE Request__r.Service__c = :suministro.Id
    ORDER BY CreatedDate DESC
];

for (Switching_Notification__c notif : historial) {
    System.debug('Tipo: ' + notif.Type__c);
    System.debug('Estado: ' + notif.Status__c);
    System.debug('Mensaje: ' + notif.Message__c);
    System.debug('Proceso: ' + notif.Request__r.Process_Type__c);
    System.debug('Fecha: ' + notif.CreatedDate);
}
```

Estos ejemplos muestran cómo utilizar las principales funcionalidades del sistema. Para más información sobre cada método o clase, consulta la documentación específica de cada componente. 