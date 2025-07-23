module perip_controladorderiego(
    input clk,
    input reset,
    input [31:0] d_in,
    input cs,
    input [31:0] addr,
    input rd,
    input wr,
    input ready_from_esp,
    output reg [31:0] d_out,
    output wire enable_esp,
    output wire led_valvula
);

    localparam integer SET_TURBIDEZ = 5'h01;
    localparam integer GET_ENABLE   = 5'h03;
    localparam integer GET_LED      = 5'h04;

    reg [3:0] turbidez_reg = 0;

    always @(posedge clk) begin 
        if (reset) begin 
            turbidez_reg <= 0;            
        end else if (cs && wr) begin 
            if (addr[4:0] == SET_TURBIDEZ)
                turbidez_reg <= d_in[3:0];
        end
    end

    always @(*) begin 
        if (cs && rd) begin 
            case (addr[4:0])
                GET_ENABLE: d_out = {31'b0, enable_esp};
                GET_LED:    d_out = {31'b0, led_valvula};
                default:    d_out = 32'b0;
            endcase
        end else begin 
            d_out = 32'b0;
        end
    end

    controladorderiego controladorderiego_inst (
        .clk(clk),
        .reset(reset),
        .turbidez(turbidez_reg),
        .ready_from_esp(ready_from_esp),
        .enable_esp(enable_esp),
        .led_valvula(led_valvula)
    );

endmodule

