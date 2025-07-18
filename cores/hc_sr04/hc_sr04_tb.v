`timescale 1ns / 1ps

module tb_hc_sr04;

    reg clk;
    reg rst;
    reg echo;
    wire trigger;
    wire [15:0] distance;

    hc_sr04 uut (
        .clk(clk),
        .rst(rst),
        .echo(echo),
        .trigger(trigger),
        .distance(distance)
    );

    // Clock de 25MHz => Periodo = 40ns
    always #20 clk = ~clk;

    initial begin
        // Configuración del archivo de onda
        $dumpfile("hc_sr04.vcd");
        $dumpvars(0, tb_hc_sr04);  // Grabar todas las señales del testbench
        
        // Inicialización
        clk = 0;
        rst = 1;
        echo = 0;
        #100;

        rst = 0;

        // Esperamos que el módulo emita un pulso de trigger
        #17000;

        // Simulamos señal echo en alto por 1 ms (25000 ciclos a 25MHz)
        echo = 1;
        #1000000; // 1 ms

        echo = 0;

        // Esperamos un poco
        #5000;

        $display("Distancia medida: %d", distance);
        $finish;
    end
    
endmodule
