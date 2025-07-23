module perip_hc_sr04(
    // Interfaz con el bus
    input clk,
    input rst,
    input [31:0] d_in,
    input cs,
    input [4:0] addr,
    input rd,
    input wr,
    output reg [31:0] d_out,
    
    // Interfaz con el sensor
    input echo,
    output trigger,
    output activar_bomba  // Salida para controlar bomba/rele
);

    // Registros mapeados
    localparam REG_DISTANCE = 5'h00;  // RO: distancia en ticks
    localparam REG_UMBRAL   = 5'h04;  // RW: umbral en ticks
    localparam REG_CONTROL  = 5'h08;  // RW: registro de control
    
    reg [15:0] umbral_reg = 16'h5A00; // Valor por defecto (~1m)
    reg enable_sensor = 1'b1;          // Habilitación del sensor

    // Instancia del módulo HC-SR04
    wire [15:0] distance;
    hc_sr04 hc_sr04_inst (
        .clk(clk),
        .rst(rst || !enable_sensor), // Reset cuando está deshabilitado
        .echo(echo),
        .trigger(trigger),
        .umbral(umbral_reg),
        .distance(distance),
        .activar(activar_bomba)
    );

    // Lógica de escritura
    always @(posedge clk) begin
        if (rst) begin
            umbral_reg <= 16'h5A00;
            enable_sensor <= 1'b1;
        end else if (cs && wr) begin
            case (addr[4:0])
                REG_UMBRAL: umbral_reg <= d_in[15:0];
                REG_CONTROL: enable_sensor <= d_in[0];
            endcase
        end
    end

    // Lógica de lectura
    always @(*) begin
        d_out = 32'h0;
        if (cs && rd) begin
            case (addr[4:0])
                REG_DISTANCE: d_out = {16'h0, distance};
                REG_UMBRAL: d_out = {16'h0, umbral_reg};
                REG_CONTROL: d_out = {31'h0, enable_sensor};
                default: d_out = 32'h0;
            endcase
        end
    end
endmodule
