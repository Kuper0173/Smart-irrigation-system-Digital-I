module led_pwm(
  input clk,
  input [16:0] duty,
  input [16:0] freq,
  output reg pwm
);

reg [16:0] count = 0;

always @(posedge clk) begin
  // 1
  count <= count +1;
  // 2
  if (count >= freq) begin
  count <=0;
  end
  // 3
  if (count <= duty) begin
    pwm <= 1;
    end else begin
    pwm <= 0;
  end
end
  
endmodule
