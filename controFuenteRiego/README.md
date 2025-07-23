# Modulo de control inteligente de riego

Este proyecto implementa un sistema embebido sobre FPGA, el cual recibe parametros de otros modulos (sensores) y en base a esas mediciones se controla el tiempo de riego y la frecuencia del mismo.

---

##  Requerimientos Funcionales

Mediante protocolos de comunicacion por MQTT se reciben los parametros de humedad de la tierra, funcionalidad de la bomba de agua, cantidad de agua y la temperatura ambiente. A su vez se incluye un interruptor de encendido/apagado.
La salida esta en funcion de la temperatura del ambiente la cual entre mayor sea da mayor tiempo de irrigacion de la plantacion.

Esta salida excita un relevador el cual actua como interruptor y abre el paso a la apertura de la valvula.

---

##  Diagrama ASM / Máquina de Estados / Diagrama de Flujo

> Inserta aquí una imagen o enlace al diagrama ASM o de estados.

`[Espacio para gráfica]`

---

##  Diagrama RTL

<img width="1220" height="636" alt="Captura de pantalla de 2025-07-23 04-58-15" src="https://github.com/user-attachments/assets/e055b7b1-6c8a-44be-a8ad-acc20449a036" />

El montaje y la simuulacion fueron hechas con Digital.

---

##  Simulación del Diseño

> Resultado de simulaciones utilizando `verilog-gtkwave` o video del entorno Digital.

- Comando: `make sim`
- Enlace al video de simulación (YouTube):  
`[Enlace a YouTube]`

---

##  Logs de Síntesis y Place & Route

> Se analizan los archivos `log-pnr` y `log-syn` generados por los comandos:

- `make log-syn`
- `make log-pnr`

Incluye:
- Recursos utilizados (LUTs, FFs, BRAM, etc.)
- Warnings relevantes y cómo fueron tratados

`[Fragmento del log o imagen]`

---

##  Interacción con Aplicaciones Externas

> Descripción de cómo se comunica este diseño con otras plataformas o aplicaciones (MQTT, Chuck, etc.).

- Protocolo utilizado
- Flujo de datos
- Comandos específicos, si aplica

---

## 📦 Archivos Incluidos

- Archivos fuente del SoC (`.v`)
- Scripts de simulación
- Logs y resultados de síntesis
- Imágenes y diagramas

---

##  Video Explicativo

> Video con explicación completa del flujo de diseño, implementación y pruebas.

`[Enlace a YouTube]`

---

##  Contexto del Proyecto y Arquitectura General

> Breve explicación sobre el objetivo del proyecto, la arquitectura general del sistema y cómo se integra el módulo en ella.

`[Espacio para incluir imagen general del SoC o arquitectura]`

---

> *Este archivo forma parte de la entrega final del proyecto de diseño digital sobre FPGA con enfoque SoC. Todos los resultados han sido generados usando herramientas de código abierto.*

