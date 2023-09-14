`timescale 1ns / 1ps


module NEXYS_Wrapper(
    input logic [4:0] btn,
    input logic [15:0] sw,
    input logic clk,
    output logic [15:0] led,
    output logic [7:0] sseg,
    output logic [7:0] an
    );
    
	logic refresh_rate;
    logic [11:0] timer;

    sseg4_TDM uutd(
        .clock(clk),
        .reset(btn[4]),
        .data({4'b0000,timer}),
        .hex_dec(sw[15]),
        .sign(sw[14]),
        .seg(sseg[6:0]),
        .dp(sseg[7]),
        .an(an));
    
    count_n# (.N(10)) counter(
        .clk(refresh_rate),
        .rst(btn[4]),
        .en(sw[0]),
        .up(1'b1),
        .count(timer));
        
    count_n# (.N(16)) refresh(
        .clk(clk),
        .rst(btn[4]),
        .en(1'b1),
        .up(1'b1),
        .tic(refresh_rate));
    
endmodule
