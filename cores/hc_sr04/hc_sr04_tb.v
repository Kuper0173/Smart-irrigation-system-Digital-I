`timescale 1ns / 1ps

module hc_sr04_tb();

    // Parámetros para 25MHz
    parameter CLK_PERIOD = 40;  // 40ns = 25MHz
    parameter TICKS_PER_CM = 58;
    parameter TRIGGER_DURATION = 375; // 15us en ticks a 25MHz

    // Señales
    reg clk;
    reg rst_n;
    reg echo;
    reg [15:0] umbral;
    wire trigger;
    wire [15:0] distance;
    wire activar;

    // Instancia del módulo bajo prueba
    hc_sr04 dut (
        .clk(clk),
        .rst(~rst_n),
        .echo(echo),
        .umbral(umbral),
        .trigger(trigger),
        .distance(distance),
        .activar(activar)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Tarea para generar eco
    task gen_echo;
        input real distance_cm;
        integer duration;
        begin
            duration = distance_cm * TICKS_PER_CM;
            echo = 1'b1;
            #(duration);
            echo = 1'b0;
        end
    endtask

    // Secuencia de prueba principal
    initial begin
        // Configuración del dumpfile
        $dumpfile("hc_sr04_tb.vcd");
        $dumpvars(0, hc_sr04_tb);
        
        // Inicialización
        rst_n = 1'b0;
        echo = 1'b0;
        umbral = 16'd5800; // 100cm
        
        // Reset
        #100;
        rst_n = 1'b1;
        #100;
        
        // Test 1: Distancia bajo umbral
        $display("[TEST 1] Distancia 50cm (<100cm umbral)");
        wait(trigger == 1'b1);
        #100000;
        gen_echo(50.0);
        #10000;
        
        if (activar !== 1'b0) begin
            $display("ERROR: TEST 1 Falló - activar debería ser 0");
            $finish;
        end
        else begin
            $display("TEST 1 Pasó");
        end
        
        // Test 2: Distancia sobre umbral
        $display("[TEST 2] Distancia 150cm (>100cm umbral)");
        wait(trigger == 1'b1);
        #500;
        gen_echo(150.0);
        #500;
        
        if (activar !== 1'b1) begin
            $display("ERROR: TEST 2 Falló - activar debería ser 1");
            $finish;
        end
        else begin
            $display("TEST 2 Pasó");
        end
        
        // Test 3: Cambio de umbral
        $display("[TEST 3] Cambio de umbral a 50cm");
        umbral = 16'd2900; // 50cm
        #100;
        
        wait(trigger == 1'b1);
        #1000;
        gen_echo(60.0);
        #10000;
        
        if (activar !== 1'b1) begin
            $display("ERROR: TEST 3 Falló - activar debería ser 1");
            $finish;
        end
        else begin
            $display("TEST 3 Pasó");
        end
        
        // Finalización
        #1000;
        $display("Simulación completada exitosamente");
        $finish;
    end

    // Monitor de eventos
    always @(posedge trigger) begin
        $display("Trigger detectado en %t ns", $time);
    end

    always @(activar) begin
        $display("Estado activar cambiado a %b en %t ns", activar, $time);
    end
endmodule
