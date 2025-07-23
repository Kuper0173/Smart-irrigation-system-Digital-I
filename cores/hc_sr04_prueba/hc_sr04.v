module hc_sr04 (
    input clk,               // 25 MHz clock
    input rst,               // Reset
    input echo,              // Echo input
    output reg trigger,      // Trigger output
    output reg [15:0] distance // Resultado en "ticks"
);

    reg [15:0] con_out = 0;
    reg [15:0] con_in = 0;
    reg [1:0] state = 0;

    localparam IDLE     = 2'd0,
               TRIGGER  = 2'd1,
               ECHO_WAIT = 2'd2,
               ECHO_READ = 2'd3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            trigger <= 0;
            con_out <= 0;
            con_in <= 0;
            distance <= 0;
        end else begin
            case (state)
                IDLE: begin
                    trigger <= 1;
                    con_out <= 0;
                    state <= TRIGGER;
                end
                TRIGGER: begin
                    if (con_out < 375) begin  // 15us = 375 ciclos a 25MHz
                        con_out <= con_out + 1;
                    end else begin
                        trigger <= 0;
                        con_out <= 0;
                        state <= ECHO_WAIT;
                    end
                end
                ECHO_WAIT: begin
                    if (echo == 1) begin
                        con_in <= 0;
                        state <= ECHO_READ;
                    end
                end
                ECHO_READ: begin
                    if (echo == 1) begin
                        con_in <= con_in + 1;
                    end else begin
                        distance <= con_in;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule

