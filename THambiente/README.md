# Informe del Proyecto: Sensor DHT11 con FPGA BlackIceMX

## Introducción

Este proyecto tiene como objetivo la implementación de un sistema para la medición de temperatura ambiental utilizando la FPGA **BlackIceMX** de **Mystorm**. El sistema interactúa con el sensor **DHT11** para leer la temperatura, procesa los datos a través de un diseño realizado en **Verilog** y los muestra en dos displays de siete segmentos. Además, se implementa un sistema de alerta que se activa manualmente a través de un **ESP32**.

Este tipo de sistemas embebidos es fundamental en aplicaciones de **Internet de las Cosas (IoT)**, donde es necesario medir, controlar y monitorear condiciones físicas de forma remota, lo cual tiene aplicaciones en áreas como la automatización del hogar y la industria.

## Contexto

Este proyecto se desarrolla dentro de un entorno académico con el propósito de simular la implementación de un sistema de monitoreo ambiental orientado a su aplicación en una plantación de café. El objetivo es diseñar un módulo capaz de leer la temperatura ambiente utilizando un sensor digital (**DHT11**), procesar la información mediante una FPGA (**BlackIceMX**), y enviar los datos a través de un módulo **ESP32** hacia una red de comunicación basada en el protocolo **MQTT** (Message Queuing Telemetry Transport).

Debido a su carácter académico, el alcance del proyecto está limitado a la lectura de temperatura dentro del laboratorio y a la configuración del **ESP32** para conectarse a una red **MQTT** preexistente, sin abordar la implementación completa del broker de la red. Sin embargo, el diseño y configuración se dejan preparados para una integración real futura.

La elección de una plantación de café como escenario de aplicación responde a la relevancia de este cultivo en el contexto económico y social de Colombia, donde el café representa uno de los principales productos de exportación, después de los recursos mineroenergéticos. En la coyuntura actual, el país enfrenta un proceso de transición energética que busca reducir la dependencia de la explotación de recursos mineros y de hidrocarburos, impulsando sectores agrícolas estratégicos como el café. Además, los precios internacionales del café han alcanzado máximos históricos recientemente, lo que lo convierte en una actividad económica cada vez más atractiva para los agricultores colombianos.

## Objetivos

El objetivo principal de este proyecto es diseñar y desarrollar un sistema basado en FPGA que sea capaz de realizar lo siguiente:

- Leer la temperatura ambiental a través del **sensor DHT11**.
- Mostrar la temperatura en dos displays de siete segmentos.
- Activar una alerta manualmente a través de un módulo **ESP32**.

Este sistema tiene como finalidad integrar los conocimientos adquiridos en la materia Digital 1 y aplicar conceptos de diseño en Verilog, programación en FPGA y control de periféricos como el sensor DHT11 y los displays de 7 segmentos.

## Componentes Utilizados

Los componentes clave utilizados en este proyecto son:

- **FPGA BlackIceMX**: Plataforma de desarrollo basada en la FPGA **Ice40HX4K** de **Lattice Semiconductor**. Se utilizó para implementar el sistema digital y manejar la entrada y salida de datos.
- **Sensor DHT11**: Sensor digital utilizado para medir la temperatura ambiental. Aunque el DHT11 también proporciona datos sobre la humedad, en este proyecto solo se utiliza la lectura de temperatura.
- **Displays de 7 segmentos**: Se utilizaron dos displays de 7 segmentos para mostrar la temperatura de manera visual. Cada display muestra un dígito de la temperatura medida. El sistema está configurado para usar un multiplexado simple para mostrar los dos dígitos.
- **ESP32**: Módulo de comunicaciones inalámbricas (WiFi y Bluetooth) que se utilizará para enviar una alerta cuando el sistema lo requiera de forma manual.

## Requerimientos Funcionales del Proyecto 

### 1. Medición de Temperatura 

- El sistema debe ser capaz de leer la temperatura ambiental mediante el sensor **DHT11**.
- La lectura de la temperatura debe ser procesada correctamente por la FPGA, utilizando un diseño en **Verilog** para la conversión de la señal digital del **DHT11** a un valor binario.

### 2. Visualización de la Temperatura 

- La temperatura leída debe ser convertida en formato **BCD** para su visualización.
- La temperatura debe ser mostrada en dos **displays de 7 segmentos**. El display de la **unidad** (derecho) mostrará las unidades de la temperatura, mientras que el display de la **decena** (izquierdo) mostrará las decenas de la temperatura.
- El sistema debe utilizar un **multiplexado** para alternar entre los dos displays y mostrar de manera eficiente los valores de la temperatura.

### 3. Envío de Alerta Manual 

- El sistema debe permitir la activación manual de la alerta mediante un módulo **ESP32**.
- La alerta debe enviarse a través de **WiFi** utilizando el módulo **ESP32**.
- La alerta debe enviarse a una **aplicación o servidor en línea** para su visualización.
- La alerta debe ser activada manualmente por el usuario a través de un mecanismo de control definido (por ejemplo, un botón o comando específico).

### 4. Interfaz con la Consola 

- El sistema debe ser capaz de leer y mostrar la temperatura de forma manual desde la **consola**.
- La temperatura leída de la consola debe ser procesada y visualizada correctamente en los displays de 7 segmentos.

### 5. Integración de Componentes 

- El sistema debe integrar correctamente la lectura del sensor **DHT11**, la conversión de temperatura, la visualización en los displays de 7 segmentos y el envío de alerta mediante el **ESP32**.
- Los componentes de la FPGA, el **DHT11**, los displays de 7 segmentos y el **ESP32** deben interactuar de forma eficiente a través de los periféricos y las señales de control configuradas en **Verilog**.

### 6. Fiabilidad del Sistema 

- El sistema debe funcionar de manera confiable en el entorno de laboratorio, con mediciones precisas de temperatura y alertas manuales efectivas.
- Debe ser posible modificar los valores de temperatura y visualizarlos de manera correcta en tiempo real, tanto en los displays de 7 segmentos como en la consola.

### 7. Soporte para Futuras Integraciones 

- El sistema debe estar preparado para integrarse fácilmente con redes **MQTT** o otros protocolos de comunicación, aunque la integración completa del broker de la red no se aborda en este proyecto.


## Herramientas y Lenguajes Utilizados

- **Lenguaje de Descripción de Hardware (HDL): Verilog** fue utilizado para diseñar el sistema digital en la FPGA, permitiendo leer los datos del sensor, procesarlos y mostrarlos en los displays.
- **Herramientas de Simulación**: Se utilizó **Xilinx ISE (XLT Lite)** para simular y verificar el comportamiento del sistema antes de implementarlo en la FPGA.
- **IDE y Entorno de Desarrollo**: El proyecto fue desarrollado en el entorno adecuado para la FPGA BlackIceMX, que incluye herramientas para la síntesis y la carga del diseño en la FPGA.

## Descripción del Proyecto

Este proyecto consiste en la implementación de un sistema basado en FPGA que interactúa con un sensor **DHT11** para obtener la temperatura. A continuación se detallan los pasos involucrados en el sistema:

### Lectura de la Temperatura

El sensor **DHT11** envía datos de temperatura en formato digital. Estos datos son leídos por la FPGA mediante un proceso de temporización que captura la señal digital del sensor. La FPGA está diseñada para interpretar correctamente los datos del sensor y extraer el valor de temperatura.

### Procesamiento en Verilog

El diseño en **Verilog** permite procesar los datos obtenidos del sensor. El código en Verilog se encarga de gestionar las señales del **DHT11**, decodificar la información de la temperatura y luego convertirla en un formato adecuado para su visualización.

### Visualización en Displays de 7 Segmentos

Una vez que la temperatura es procesada por la FPGA, el siguiente paso es mostrarla en los displays de 7 segmentos. Cada display muestra un dígito de la temperatura medida. El código en Verilog controla el encendido y apagado de los segmentos del display para representar los dígitos de la temperatura. Se utiliza un **multiplexado** para controlar ambos displays de forma eficiente, mostrando los valores de las decenas y las unidades.

### Creación del Periférico

Se crea un periférico específico para gestionar la lectura del sensor DHT11 y la transmisión de datos al procesador de la FPGA. Esto facilita la interacción entre la FPGA y el sensor de manera eficiente, usando una dirección de memoria para la lectura de la temperatura.

### Envío de Alerta con ESP32

El **ESP32** se utiliza para enviar una alerta cuando se desee de forma manual. El sistema permite la activación manual de este proceso, enviando una notificación a través de **WiFi** a una aplicación o servidor en línea.


## Diagrama de Conexión

![Diagrama de Conexión](https://github.com/Kuper0173/Smart-irrigation-system-Digital-I/blob/main/THambiente/Mapa%20de%20conexiones_fritzig.jpg.png)

En este modelo, se muestra el diagrama de conexiones en la plataforma **Fritzing**. Las conexiones entre los displays de 7 segmentos y la FPGA se realizan mediante un mapeo directo de pines: **A-A, B-B, C-C**, y así sucesivamente. Para proteger los displays de posibles sobrecargas, estas conexiones se realizan a través de **resistencias de 220 ohmios**, lo que ayuda a evitar daños por corriente excesiva.

En el diagrama, los cables morados representan los **jumpers** que conectan la FPGA con los displays. También se observa el **sensor de temperatura DHT11**, conectado a las líneas de **tierra** (GND) de la protoboard, así como al voltaje y la tierra de la FPGA.

Las conexiones en Fritzing representan las salidas de la FPGA, las cuales están mapeadas al hardware real de la **BlackIceMX de Mystorm**. De esta forma, el diagrama simula cómo se conectarían los componentes en el entorno físico.

A continuación, se muestra la conexión real del circuito a la fpga:

![Diagrama de Conexión](https://github.com/Kuper0173/Smart-irrigation-system-Digital-I/blob/main/THambiente/Mapa%20de%20conexiones.jpg)

Este diagrama ilustra cómo están conectados los pines de la FPGA BlackIceMX al sensor **DHT11**, los displays de 7 segmentos y el módulo **ESP32** para el envío de alertas. Los pines están configurados de acuerdo a la asignación especificada en el archivo **SOC.pcf**.

## Diagrama de Flujo

El siguiente diagrama de flujo describe el comportamiento general del sistema:
![Flujo1](https://github.com/Kuper0173/Smart-irrigation-system-Digital-I/blob/main/THambiente/Flujo1.jpg)

![Flujo2](https://github.com/Kuper0173/Smart-irrigation-system-Digital-I/blob/main/THambiente/Flujo%202.jpg)




1. **Lectura del DHT11**: La FPGA lee la temperatura del sensor DHT11.
2. **Procesamiento de la Temperatura**: Los datos leídos son procesados en Verilog y convertidos a formato BCD para su visualización.
3. **Visualización en Displays**: Los valores de temperatura (decenas y unidades) son mostrados en los displays de 7 segmentos mediante multiplexado.
4. **Comprobación del Umbral de Temperatura**: Si la temperatura supera el umbral, el sistema activa el **ESP32**.
5. **Envío de Alerta**: El **ESP32** envía una alerta a través de WiFi a un servidor o aplicación.

## Arquitectura del Sistema

![Flujo2](https://github.com/Kuper0173/Smart-irrigation-system-Digital-I/blob/main/THambiente/Arquitectura.jpg)

La figura muestra la interacción entre los módulos lógicos y los dispositivos físicos que componen el proyecto:

| Bloque | Función principal | Flujos de datos relevantes |
|--------|------------------|----------------------------|
| **PC** | Punto de control para pruebas y depuración. Desde un terminal se envían comandos o se reciben lecturas de temperatura. | • Conexión USB (picom) → **FTDI FT123RL** |
| **FTDI FT123RL** | Puente USB-UART que convierte los datos provenientes del PC al nivel lógico que entiende la FPGA. | • Líneas RX/TX ↔ **CPU** (FPGA) |
| **Sensor DHT11** | Fuente de la temperatura real. Envía los datos digitales a la FPGA. | • Línea de datos → **CPU** |
| **FPGA (BlackIceMX)** | Núcleo del sistema. Contiene:<br>  • **CPU FemtoRV32** (ejecuta el firmware).<br>  • **Memoria** de programa/datos.<br>  • **Selector de chip** (decodifica direcciones y habilita periféricos).<br>  • **Periférico de multiplexado** (control de displays).<br>  • **UART** (enlace con ESP32). | • CPU ↔ Memoria y periféricos.<br>• CPU ↔ UART (TX/RX) |
| **Displays de 7 segmentos** | Muestran la temperatura (decenas y unidades) controlados por el periférico de multiplexado. | • Señales de segmento/ánodo ← Periférico (FPGA) |
| **ESP32** | Nodo IoT. Recibe la temperatura vía UART y la publica por Wi-Fi/MQTT cuando el usuario la solicita. | • UART RX/TX ↔ FPGA.<br>• Wi-Fi/MQTT ↔ red externa |

### Secuencia de operación (resumen)

1. El **PC** envía comandos o lee resultados por USB; el **FTDI** traduce USB ↔ UART.  
2. La **CPU** de la FPGA lee la temperatura del **DHT11**, la almacena en memoria y la distribuye:  
   - Al periférico de los **displays** para visualizarla localmente.  
   - Por UART al **ESP32** cuando el usuario lo indica.  
3. El **ESP32** publica la lectura por Wi-Fi/MQTT, cerrando el flujo “sensor → visualización local → publicación remota”.

Con esta arquitectura se separan claramente la adquisición de datos (DHT11 → FPGA), la presentación local (displays) y la distribución inalámbrica (ESP32), manteniendo al **PC** como herramienta de depuración y control.

## Simulación del Circuito en Digital

Este es un diagrama de simulación realizado en **Digital**, un software utilizado para diseñar y simular circuitos digitales. El circuito mostrado en la imagen es un sistema de multiplexado y decodificación para un **display de 7 segmentos**.

### Explicación del Circuito:

1. **Demux 2x1**: Este componente se utiliza para dirigir las señales de entrada a dos salidas diferentes (Y0 y Y1) según el valor de la señal de selección (S). Esta es una forma de multiplicar las salidas y controlar las señales de manera eficiente para la visualización en los displays de 7 segmentos.

2. **MUX 2x1**: El multiplexor selecciona una de las dos señales de entrada (W0, W1, W2, W3 y Z0, Z1, Z2, Z3) en función de la señal de selección S. Este proceso se usa para decidir qué dígitos se van a mostrar en los displays de 7 segmentos.

3. **Decodificadores de 7 segmentos (DECO 1 y DECO 2)**: Estos decodificadores convierten las señales binarias de los multiplexores en señales de control para los segmentos de los displays de 7 segmentos. Cada salida de los decodificadores se conecta a los segmentos correspondientes del display, lo que permite representar números del 0 al 9.

4. **Displays de 7 segmentos**: Los displays visualizan la temperatura, números o cualquier dato que se necesite mostrar. Cada display está controlado por un decodificador que convierte las señales binarias de los multiplexores en formato adecuado para ser visualizado.

### Simulación:

Este diagrama es parte de la simulación que se ejecuta en **Digital**, donde se pueden ver en tiempo real cómo las señales viajan a través de los componentes y cómo se muestran los números en los displays de 7 segmentos. A través de esta simulación, se puede verificar el comportamiento y la correcta implementación del sistema antes de llevarlo a la práctica.

---

**En este [link](https://www.youtube.com/watch?v=Dt64bOUN48Q)** encontrarán un video explicando en detalle la simulación de este circuito, donde se muestra cómo cada componente interactúa y cómo se visualizan los resultados en los displays de 7 segmentos.


## Resultados Esperados

- **Medición precisa de temperatura**: El sistema debe ser capaz de leer correctamente la temperatura del **DHT11** o, en su defecto, mostrar los datos ingresados manualmente.
- **Visualización correcta**: La temperatura debe ser mostrada en los dos displays de 7 segmentos.
- **Alerta manual**: El sistema debe ser capaz de enviar una alerta a través de la conexión con el **ESP32** de forma manual, que posteriormente envíe la información a un servidor en línea.

## Problemas Encontrados

Durante el desarrollo del proyecto, se presentaron algunos problemas técnicos relacionados con el sensor **DHT11**. A pesar de que inicialmente se planeó utilizar este sensor para leer la temperatura y activar la alerta cuando la temperatura excediera un umbral predefinido, se encontraron dificultades en la comunicación del sensor con la FPGA.

- **Problema con el Sensor DHT11**: El sistema no funcionó correctamente con el sensor DHT11 en la implementación inicial. La lectura de los datos no se realizaba de forma confiable, lo que generaba errores en la medición de la temperatura.
  
- **Solución**: Debido a esto, el sistema fue ajustado para **leer la temperatura por consola** en lugar de depender directamente del sensor. La temperatura leída es mostrada correctamente en los displays de siete segmentos, y el valor es procesado y visualizado sin problemas.

- **Alerta Manual con ESP32**: En lugar de activar la alerta automáticamente al superar un umbral de temperatura, la alerta ahora es enviada **manual** mediante el **ESP32**, lo que permite a los usuarios controlar cuándo se desea enviar la notificación.


## Conclusión

Este proyecto permite integrar varios conceptos fundamentales de electrónica digital, FPGA y sistemas embebidos. Al combinar la lectura de un sensor, el procesamiento de datos en una FPGA y la comunicación inalámbrica con un ESP32, el proyecto cubre una amplia gama de habilidades necesarias en proyectos de ingeniería electrónica.

El éxito de este proyecto dependerá de la correcta implementación y simulación del diseño en Verilog, así como de la configuración adecuada de los componentes electrónicos. Una vez implementado, el sistema será capaz de medir la temperatura de manera eficiente y enviar alertas a través de internet en tiempo real, mejorando las capacidades de monitoreo remoto en tiempo real.

## Referencias

1. **FPGA BlackIceMX**: [Mystorm FPGA Documentation](https://mystorm.hackaday.io/)
2. **DHT11**: [DHT11 Sensor Datasheet](https://www.sparkfun.com/datasheets/Sensors/Temperature/DHT11.pdf)
3. **Verilog HDL**: [Verilog Tutorial](https://www.tutorialspoint.com/verilog/index.htm)
4. **ESP32**: [ESP32 Documentation](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/)
