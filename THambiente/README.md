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

## Problemas Encontrados

Durante el desarrollo del proyecto, se presentaron algunos problemas técnicos relacionados con el sensor **DHT11**. A pesar de que inicialmente se planeó utilizar este sensor para leer la temperatura y activar la alerta cuando la temperatura excediera un umbral predefinido, se encontraron dificultades en la comunicación del sensor con la FPGA.

- **Problema con el Sensor DHT11**: El sistema no funcionó correctamente con el sensor DHT11 en la implementación inicial. La lectura de los datos no se realizaba de forma confiable, lo que generaba errores en la medición de la temperatura.
  
- **Solución**: Debido a esto, el sistema fue ajustado para **leer la temperatura por consola** en lugar de depender directamente del sensor. La temperatura leída es mostrada correctamente en los displays de siete segmentos, y el valor es procesado y visualizado sin problemas.

- **Alerta Manual con ESP32**: En lugar de activar la alerta automáticamente al superar un umbral de temperatura, la alerta ahora es enviada **manual** mediante el **ESP32**, lo que permite a los usuarios controlar cuándo se desea enviar la notificación.

## Diagrama de Conexión

A continuación, se muestra el diagrama de conexiones entre los componentes principales:

![Diagrama de Conexión]([ruta/a/tu/diagrama.png](https://github.com/Kuper0173/Smart-irrigation-system-Digital-I/blob/main/THambiente/Mapa%20de%20conexiones.jpg))

Este diagrama ilustra cómo están conectados los pines de la FPGA BlackIceMX al sensor **DHT11**, los displays de 7 segmentos y el módulo **ESP32** para el envío de alertas. Los pines están configurados de acuerdo a la asignación especificada en el archivo **SOC.pcf**.

## Diagrama de Flujo

El siguiente diagrama de flujo describe el comportamiento general del sistema:

1. **Lectura del DHT11**: La FPGA lee la temperatura del sensor DHT11.
2. **Procesamiento de la Temperatura**: Los datos leídos son procesados en Verilog y convertidos a formato BCD para su visualización.
3. **Visualización en Displays**: Los valores de temperatura (decenas y unidades) son mostrados en los displays de 7 segmentos mediante multiplexado.
4. **Comprobación del Umbral de Temperatura**: Si la temperatura supera el umbral, el sistema activa el **ESP32**.
5. **Envío de Alerta**: El **ESP32** envía una alerta a través de WiFi a un servidor o aplicación.

## Resultados Esperados

- **Medición precisa de temperatura**: El sistema debe ser capaz de leer correctamente la temperatura del **DHT11** o, en su defecto, mostrar los datos ingresados manualmente.
- **Visualización correcta**: La temperatura debe ser mostrada en los dos displays de 7 segmentos.
- **Alerta manual**: El sistema debe ser capaz de enviar una alerta a través de la conexión con el **ESP32** de forma manual, que posteriormente envíe la información a un servidor en línea.

## Conclusión

Este proyecto permite integrar varios conceptos fundamentales de electrónica digital, FPGA y sistemas embebidos. Al combinar la lectura de un sensor, el procesamiento de datos en una FPGA y la comunicación inalámbrica con un ESP32, el proyecto cubre una amplia gama de habilidades necesarias en proyectos de ingeniería electrónica.

El éxito de este proyecto dependerá de la correcta implementación y simulación del diseño en Verilog, así como de la configuración adecuada de los componentes electrónicos. Una vez implementado, el sistema será capaz de medir la temperatura de manera eficiente y enviar alertas a través de internet en tiempo real, mejorando las capacidades de monitoreo remoto en tiempo real.

## Referencias

1. **FPGA BlackIceMX**: [Mystorm FPGA Documentation](https://mystorm.hackaday.io/)
2. **DHT11**: [DHT11 Sensor Datasheet](https://www.sparkfun.com/datasheets/Sensors/Temperature/DHT11.pdf)
3. **Verilog HDL**: [Verilog Tutorial](https://www.tutorialspoint.com/verilog/index.htm)
4. **ESP32**: [ESP32 Documentation](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/)
