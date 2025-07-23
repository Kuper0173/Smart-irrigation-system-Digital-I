`timescale 1ns / 1ns
`ifndef TIME_UNIT
`define TIME_UNIT 20  // 20 ns -> clk de 25 MHz (periodo total 40 ns)
`endif

module controladorderiego_tb;

  // Entradas
  reg clk = 0;
  reg reset;
  reg [3:0] turbidez;
  reg ready_from_esp;

  // Salidas
  wire enable_esp;
  wire led_valvula;

  // Generación de reloj: 25 MHz
  always #(`TIME_UNIT) clk = ~clk;

  // Instancia del DUT
  controladorderiego dut (
    .clk(clk),
    .reset(reset),
    .turbidez(turbidez),
    .ready_from_esp(ready_from_esp),
    .enable_esp(enable_esp),
    .led_valvula(led_valvula)
  );

  // Estímulos
  initial begin
    // Inicialización
    reset = 1;
    turbidez = 0;
    ready_from_esp = 0;

    // Liberar reset
    #(`TIME_UNIT * 4)
    reset = 0;

    // Esperar a que FSM llegue a ENABLE_ESP y active enable_esp
    wait (enable_esp == 1);
    $display("[%0t] enable_esp activo", $time);

    // Simular envío de datos desde la ESP32
    #(`TIME_UNIT * 4)
    turbidez = 12;  // Alta turbidez
    ready_from_esp = 1;

    #(`TIME_UNIT * 2)
    ready_from_esp = 0;  // Baja bandera

    // Esperar activación de led_valvula
    wait (led_valvula == 1);
    $display("[%0t] LED encendido", $time);

    // Esperar apagado del LED (después del tiempo programado)
    wait (led_valvula == 0);
    $display("[%0t] LED apagado", $time);

    // Repetir con otro valor de turbidez
    #(`TIME_UNIT * 100)
    wait (enable_esp == 1);
    turbidez = 9;  // Turbidez media
    ready_from_esp = 1;

    #(`TIME_UNIT * 2)
    ready_from_esp = 0;

    wait (led_valvula == 1);
    $display("[%0t] LED encendido por 5s", $time);

    wait (led_valvula == 0);
    $display("[%0t] LED apagado", $time);

    #(`TIME_UNIT * 100)
    $finish;
  end

  // VCD para GTKWAVE
  initial begin
    $dumpfile("controladorderiego_tb.vcd");
    $dumpvars(0, controladorderiego_tb);
  end

endmodule

