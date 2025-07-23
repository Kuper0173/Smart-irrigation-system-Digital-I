module perip_led_pwm(
    input clk,
    input reset,
    input [31:0] d_in, // 8 bits menos significativos
    input cs,
    input [31:0] addr,
    input rd,
    input wr,
    output reg [31:0] d_out,
    output pwm
);

reg [16:0] duty = 0;
localparam integer SETDUTY = 5'h01; //En C SETDUTY  0x01

// Escribir registros
always @(posedge clk) begin 
  if(reset) begin 
    duty <= 0;
  end else begin 
    if (cs && wr) begin 
      if(addr[4:0] == SETDUTY) begin 
        duty <= {d_in[7:0],9'b0};
      end
    end
  end
end

// Leer registros
//always @(posedge clk) begin end

led_pwm led_pwm0(
  .clk(clk),
  .duty(duty),
  .freq(250000),
  .pwm(pwm)
);
endmodule
