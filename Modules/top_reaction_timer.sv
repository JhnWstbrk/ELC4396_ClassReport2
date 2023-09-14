`timescale 1ns / 1ps


module top_reaction_timer(
    input logic clk,
    input logic BTNC, BTNU, BTND, BTNR,
    output logic [7:0]an,
    output logic [7:0]sseg,
    output logic [15:0]LED,
    output logic LED16_B
    );
    
    reaction_timer my_timer(
    .clk(clk),
    .rst(BTNR),
    .start(BTNU),
    .stop(BTNC),
    .clear(BTND),
    .SW(SW),
    .an(an),
    .sseg(sseg),
    .led(LED16_B),
    .LED(LED));
endmodule
