`timescale 1s/1ms  // Unidades en milisegundos, precisión en microsegundos

module top_tb;

  // Señales de entrada
  reg HUMEDAD = 1;
  reg AGUA = 1;
  reg BOMBA = 1;
  reg ON = 0;
  reg [2:0] TEMP = 3'd0;
  reg CLK = 0;

  // Señales de salida
  wire ANDP;
  wire [7:0] SMUX;
  wire [7:0] OUTF;
  wire OUT;

  // Instancia del módulo DUT (Device Under Test)
  top DUT (
    .HUMEDAD(HUMEDAD),
    .AGUA(AGUA),
    .BOMBA(BOMBA),
    .ON(ON),
    .TEMP(TEMP),
    .CLK(CLK),
    .ANDP(ANDP),
    .SMUX(SMUX),
    .OUTF(OUTF),
    .OUT(OUT)
  );

  // Clock de 1 Hz => periodo = 1000 ms => medio ciclo = 500 ms
  always #500 CLK = ~CLK;

  initial begin
    // Archivo de salida para visualización en GTKWave
    $dumpfile("top.vcd");
    $dumpvars(0, top_tb);

    // Esperar 5 segundos (5000 ms) para encender ON
    #5000;
    ON = 1;

    // Cambiar HUMEDAD y TEMP cada 150s (150000 ms)
    repeat (4) begin
      #150000;
      HUMEDAD = ~HUMEDAD;
      TEMP = TEMP + 1;
    end

    // Esperar 10s adicionales antes de terminar (opcional)
    #10000;
    $finish;
  end

endmodule
