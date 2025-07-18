module perip_hc_sr04(   
    input clk,
    input rst,
    input [31:0] d_in,
    input cs,
    input [4:0] addr,
    input rd,
    input wr,
    output reg [31:0] d_out,
    input echo,
    output reg trigger,
  );

  reg [15:0] distance;
  localparam integer GETDISTANCE = 5'h01; // en c GETDISTANCE 0x01 
//leer registros
  always @(posedge clk) begin
  if (rst) begin
  distance <=0;
  end 
  else begin
    if (cs && rd) begin
      if (addr[4:0]==GETDISTANCE) begin
        distance <= {d_out[0:15],16'b0};
        end
      end
    end
    
    end
//

 hc_sr04 hc_sr04_1 (
  .clk(clk),
  .echo(echo),
  .trigger(trigger),
  .distance(d_out),
  .rst(rst),
);

endmodule
  
        
        
