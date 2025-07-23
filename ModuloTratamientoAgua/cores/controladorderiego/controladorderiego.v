module controladorderiego (
    input wire clk,                    // 1 Reloj de 25 MHz
    input wire reset,                 // 1 Reset asíncrono
    input wire [11:0] turbidez,        // Entrada digital desde la ESP32
    input wire ready_from_esp,       // Bandera de que el valor está disponible
    output reg enable_esp,           // Señal para activar la ESP32
    output reg led_valvula           // 1 LED de la válvula (activo en alto)
);

    // Definición de estados del sistema
    parameter IDLE       = 2'b00; 
    parameter ENABLE_ESP = 2'b01;
    parameter WAIT_DATA  = 2'b10;
    parameter LED_ON     = 2'b11;

    reg [1:0] current_state, next_state;

    reg [31:0] timer;              // Contador de tiempo
    reg [31:0] target_time;        // Tiempo objetivo (en ciclos de clk)

    // Parámetros de tiempo en ciclos de reloj (25 MHz)
    parameter CYCLES_10S = 25000000;  // 25_000_000 * 10
    parameter CYCLES_5S  = 12500000;  // 25_000_000 * 5

    // Máquina de estados: transición de estado
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Máquina de estados: lógica de transición
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                next_state = ENABLE_ESP;
            end

            ENABLE_ESP: begin
                if (ready_from_esp)
                    next_state = WAIT_DATA;
            end

            WAIT_DATA: begin
                next_state = LED_ON;
            end

            LED_ON: begin
                if (timer >= target_time)
                    next_state = IDLE;
            end
        endcase
    end

    // Lógica secuencial
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            enable_esp <= 0;
            led_valvula <= 0;
            timer <= 0;
            target_time <= 0;
        end else begin
            case (current_state)
                IDLE: begin
                    enable_esp <= 0;
                    led_valvula <= 0;
                    timer <= 0;
                end

                ENABLE_ESP: begin
                    enable_esp <= 1;
                end

                WAIT_DATA: begin
                    enable_esp <= 0;

                    // Decidir tiempo según turbidez
                    if (turbidez >= 12) begin
                        target_time <= CYCLES_10S;
                        led_valvula <= 1;
                    end else if (turbidez >= 8) begin
                        target_time <= CYCLES_5S;
                        led_valvula <= 1;
                    end else begin
                        target_time <= 0;
                        led_valvula <= 0;
                    end

                    timer <= 0;
                end

                LED_ON: begin
                    if (led_valvula)
                        timer <= timer + 1;

                    if (timer >= target_time) begin
                        led_valvula <= 0;
                        timer <= 0;
                    end
                end
            endcase
        end
    end

endmodule

