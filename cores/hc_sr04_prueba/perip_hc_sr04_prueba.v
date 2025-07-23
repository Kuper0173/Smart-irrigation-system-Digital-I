module perip_hc_sr04_prueba (
    input clk,
    input rst,
    input [31:0] d_in,
    input cs,
    input [31:0] addr,  // el tamaño de addr es de 32 bits
    input rd,
    input wr,
    output reg [31:0] d_out,
    input echo,
    output trigger  // trigger ya está definido como puerto
);

  localparam integer GETDISTANCE = 5'h01;  // Definir en C -> #define  GET_DISTANCE 0x01
  //leer registros
  always @(posedge clk) begin
    if (rst) begin
      d_out <= 0;
    end else begin
      if (cs && rd) begin  // Si hay una solicitud de lectura
        if (addr[4:0] == GETDISTANCE) begin  // Si addr corresponde a GETDISTANCE
          d_out <= {16'b0, wr_distance};  // Completar el bus con bits en 0
        end
      end
    end

  end

  wire [15:0] wr_distance;  // Es solo un cable
  hc_sr04 hc_sr04_1 (
      .clk(clk),
      .echo(echo),
      .trigger(trigger),
      .distance(wr_distance),  // 16bits
      .rst(rst),
  );

endmodule
