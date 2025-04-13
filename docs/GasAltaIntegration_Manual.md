# Manual de Integración Switching

## 1. Introducción

Este documento describe el sistema de integración de switching, incluyendo su arquitectura, funcionalidades y procesos de operación.

## 2. Arquitectura del Sistema

### 2.1 Componentes Principales

- **SwitchingIntegration**: Clase principal que maneja la integración con distribuidoras
- **SwitchingProcess**: Clase base abstracta para todos los procesos de switching
- **Procesos Específicos**:
  - `GasBajaProcess`: Proceso de baja de servicio
  - `GasCambioComercializadoraProcess`: Proceso de cambio de comercializadora
  - `GasCambioTitularProcess`: Proceso de cambio de titular
  - `GasCambioComercializadoraTitularProcess`: Proceso de cambio de comercializadora y titular
- **Switching_Message__c**: Objeto que almacena los mensajes de switching
- **SwitchingEventHandler**: Manejador de eventos del sistema

### 2.2 Jerarquía de Clases

```
BaseSwitchingProcess (abstract)
    └── SwitchingProcess (abstract)
        ├── GasBajaProcess
        ├── GasCambioComercializadoraProcess
        ├── GasCambioTitularProcess
        └── GasCambioComercializadoraTitularProcess
```

### 2.3 Flujo de Datos

1. Recepción de solicitudes de switching
2. Procesamiento y validación
3. Envío a distribuidora
4. Recepción y procesamiento de respuestas
5. Actualización de registros y notificaciones

## 3. Tipos de Mensajes

### 3.1 Estructura de Procesos

El sistema está diseñado para manejar múltiples tipos de procesos de manera modular y extensible. Cada proceso sigue una estructura común:

1. **Validación inicial**
2. **Generación de XML**
3. **Envío a distribuidora**
4. **Procesamiento de respuesta**
5. **Actualización de registros**

### 3.2 Procesos Implementados

#### 3.2.1 Baja de Gas

**Descripción**: Proceso para dar de baja un servicio de gas natural.

**Flujo del proceso**:
1. Validación de datos del cliente y servicio
2. Generación de XML de baja
3. Envío a distribuidora
4. Procesamiento de respuesta
5. Actualización del estado del servicio

**Campos requeridos**:
- CUPS (Código Unificado de Punto de Suministro)
- Fecha de efecto de la baja
- Motivo de la baja
- Datos del titular

**Estados posibles**:
- Pendiente de baja
- Baja solicitada
- Baja aceptada
- Baja rechazada
- Baja efectiva

#### 3.2.2 Cambio de Comercializadora

**Descripción**: Proceso para cambiar la comercializadora de un servicio de gas natural.

**Flujo del proceso**:
1. Validación de datos del cliente y servicio
2. Validación de la nueva comercializadora
3. Generación de XML de cambio
4. Envío a distribuidora
5. Procesamiento de respuesta
6. Actualización del estado del servicio

**Campos requeridos**:
- CUPS (Código Unificado de Punto de Suministro)
- Fecha de efecto del cambio
- Nueva comercializadora
- Datos del titular (opcional)

**Validaciones específicas**:
- El servicio debe estar activo
- La nueva comercializadora debe ser diferente a la actual
- La fecha de efecto debe ser futura

**Estados posibles**:
- Pendiente de cambio
- Cambio solicitado
- Cambio aceptado
- Cambio rechazado
- Cambio efectivo

#### 3.2.3 Cambio de Titular

**Descripción**: Proceso para cambiar el titular de un servicio de gas natural.

**Flujo del proceso**:
1. Validación de datos del servicio y nuevo titular
2. Generación de XML de cambio
3. Envío a distribuidora
4. Procesamiento de respuesta
5. Actualización del estado del servicio

**Campos requeridos**:
- CUPS (Código Unificado de Punto de Suministro)
- Nombre del nuevo titular
- NIF del nuevo titular
- Datos de contacto (opcional)

**Validaciones específicas**:
- El servicio debe estar activo
- El nuevo titular debe ser diferente al actual
- Todos los datos del nuevo titular son obligatorios

**Estados posibles**:
- Pendiente de cambio
- Cambio solicitado
- Cambio aceptado
- Cambio rechazado
- Cambio efectivo

#### 3.2.4 Cambio de Comercializadora y Titular

**Descripción**: Proceso para cambiar simultáneamente la comercializadora y el titular de un servicio de gas natural.

**Flujo del proceso**:
1. Validación de datos del servicio, nueva comercializadora y nuevo titular
2. Generación de XML de cambio
3. Envío a distribuidora
4. Procesamiento de respuesta
5. Actualización del estado del servicio

**Campos requeridos**:
- CUPS (Código Unificado de Punto de Suministro)
- Fecha de efecto del cambio
- Nueva comercializadora
- Nombre del nuevo titular
- NIF del nuevo titular
- Datos de contacto (opcional)

**Validaciones específicas**:
- El servicio debe estar activo
- La nueva comercializadora debe ser diferente a la actual
- El nuevo titular debe ser diferente al actual
- La fecha de efecto debe ser futura
- Todos los datos del nuevo titular son obligatorios

**Estados posibles**:
- Pendiente de cambio
- Cambio solicitado
- Cambio aceptado
- Cambio rechazado
- Cambio efectivo

## 4. Procesamiento de Respuestas

### 4.1 Flujo de Procesamiento

1. Recepción del XML de respuesta
2. Determinación del tipo de respuesta
3. Procesamiento específico según el tipo
4. Actualización de registros
5. Disparo de eventos correspondientes

### 4.2 Tipos de Respuesta

- **Aceptado**: La solicitud fue aceptada
- **Rechazado**: La solicitud fue rechazada
- **Pendiente**: La solicitud está en proceso
- **Activado**: El servicio ha sido activado
- **Error**: Ocurrió un error en el procesamiento

## 5. Manejo de Errores

### 5.1 Tipos de Errores

- Errores de conexión
- Errores de validación
- Errores de procesamiento
- Errores de timeout

### 5.2 Proceso de Recuperación

1. Registro del error
2. Notificación a los usuarios
3. Reintentos automáticos (si aplica)
4. Escalación manual (si es necesario)

## 6. Configuración

### 6.1 Parámetros de Conexión

- URL del servicio
- Credenciales
- Timeouts
- Número de reintentos

### 6.2 Configuración de Eventos

- Eventos a monitorear
- Destinatarios de notificaciones
- Umbrales de alerta

## 7. Mejoras Futuras

### 7.1 Optimizaciones Planificadas

- Implementación de colas de mensajes
- Mejora en el sistema de reintentos
- Dashboard de monitoreo
- Integración con sistema de tickets

### 7.2 Requisitos Técnicos

- Mejorar el manejo de concurrencia
- Implementar sistema de logging más robusto
- Optimizar el procesamiento de XML
- Mejorar el sistema de notificaciones

## 8. Troubleshooting

### 8.1 Problemas Comunes

1. **Timeout en conexiones**
   - Verificar configuración de timeout
   - Revisar logs de red
   - Validar disponibilidad del servicio

2. **Errores de validación**
   - Revisar estructura del XML
   - Validar datos requeridos
   - Verificar formatos de datos

3. **Problemas de procesamiento**
   - Revisar logs de error
   - Validar estado de los registros
   - Verificar integridad de datos

### 8.2 Procedimientos de Recuperación

1. **Recuperación automática**
   - Sistema de reintentos
   - Limpieza de registros huérfanos
   - Re sincronización de estados

2. **Intervención manual**
   - Procedimientos de escalación
   - Herramientas de diagnóstico
   - Procesos de recuperación

## 9. Contacto y Soporte

- Equipo de desarrollo: [email]
- Soporte técnico: [teléfono]
- Horario de atención: [horario]
- Sistema de tickets: [url]

## 10. Glosario

- **Switching**: Proceso de cambio de distribuidora
- **XML**: Formato de intercambio de datos
- **Endpoint**: Punto de conexión del servicio
- **Timeout**: Tiempo máximo de espera
- **Retry**: Reintento de operación
- **CUPS**: Código Unificado de Punto de Suministro
- **Titular**: Persona física o jurídica responsable del contrato
- **Comercializadora**: Empresa que vende la energía al cliente final 