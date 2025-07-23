# Proyecto SoC – FPGA BlackIce 8.2

Este proyecto implementa un sistema embebido sobre FPGA utilizando el flujo de diseño de [herramienta o entorno que uses, ej: Icestorm/Yosys/NextPNR]. El módulo desarrollado cumple funciones específicas de procesamiento y se comunica con aplicaciones externas como [MQTT, Chuck, etc.], integrándose en un sistema más amplio.

---

##  Requerimientos Funcionales

> Describir brevemente qué debe hacer el módulo (entradas, salidas, comportamiento esperado).

---

##  Diagrama ASM / Máquina de Estados / Diagrama de Flujo

> Inserta aquí una imagen o enlace al diagrama ASM o de estados.

`[Espacio para gráfica]`

---

##  Diagrama RTL

> Incluye una representación del RTL del sistema completo y del módulo específico.

- Comando utilizado: `make rtl`  
- Para módulo específico: `make rtl top=modulo_especifico`

`[Espacio para gráfica RTL principal]`  
`[Espacio para gráfica RTL del módulo]`

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

