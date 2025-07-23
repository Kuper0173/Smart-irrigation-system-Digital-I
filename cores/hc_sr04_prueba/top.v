module top (
    input clk25,
    input rst,
    input echo_pin,
    output trigger_pin,
    output [7:0] leds
);

    wire [15:0] distance;
    hc_sr04 sensor (
        .clk(clk25),
        .rst(rst),
        .echo(echo_pin),
        .trigger(trigger_pin),
        .distance(distance)
    );

    assign leds = distance[15:8];  // Mostrar distancia en LEDs (parte alta)
endmodule
