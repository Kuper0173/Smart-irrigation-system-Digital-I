`timescale 1ns / 1ps

module perip_hc_sr04_tb;

    // Señales del bus
    reg clk;
    reg rst;
    reg cs;
    reg rd;
    reg wr;
    reg [4:0] addr;
    reg [31:0] d_in;
    wire [31:0] d_out;
    
    // Señales del sensor
    reg echo;
    wire trigger;
    wire activar_bomba;

    perip_hc_sr04 uut (
        .clk(clk),
        .rst(rst),
        .d_in(d_in),
        .cs(cs),
        .addr(addr),
        .rd(rd),
        .wr(wr),
        .d_out(d_out),
        .echo(echo),
        .trigger(trigger),
        .activar_bomba(activar_bomba)
    );

    // Clock de 25MHz
    always #20 clk = ~clk;

    initial begin
        // Inicialización
        clk = 0;
        rst = 1;
        echo = 0;
        cs = 0;
        rd = 0;
        wr = 0;
        addr = 0;
        d_in = 0;
        
        // Reset
        #100;
        rst = 0;
        
        // Configurar umbral a 50cm (2900 ticks)
        #50;
        cs = 1;
        wr = 1;
        addr = 5'h04; // REG_UMBRAL
        d_in = 32'h00000B50; // 2900 ticks = ~50cm
        #40;
        cs = 0;
        wr = 0;
        
        // Esperar primer trigger
        @(posedge trigger);
        
        // Simular eco de 1ms (~100cm - debería activar bomba)
        #100000 echo = 1;
        #1000000; // 1ms
        echo = 0;
        
        // Leer distancia y estado
        #1000;
        cs = 1;
        rd = 1;
        addr = 5'h00; // REG_DISTANCE
        #40;
        $display("Distancia: %d ticks (%0.2f cm) - Bomba: %b",
                d_out[15:0], d_out[15:0]/58.0, activar_bomba);
        
        // Simular eco de 0.5ms (~50cm - en el límite)
        @(posedge trigger);
        #100000 echo = 1;
        #500000; // 0.5ms
        echo = 0;
        
        // Leer distancia y estado
        #1000;
        addr = 5'h00; // REG_DISTANCE
        #40;
        $display("Distancia: %d ticks (%0.2f cm) - Bomba: %b",
                d_out[15:0], d_out[15:0]/58.0, activar_bomba);
        
        // Finalizar
        #100;
        $finish;
    end

    initial begin
        $dumpfile("perip_hc_sr04.vcd");
        $dumpvars(0, perip_hc_sr04_tb);
    end

endmodule
