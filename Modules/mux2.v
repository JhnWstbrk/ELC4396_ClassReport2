`timescale 1ns / 1ps
// John Westbrook, ELC 2137, 10/12/2021


module mux2 #(parameter N = 1)(
    input [N-1:0] in0,
    input [N-1:0] in1,
    input sel,
    output [N-1:0] out
    );
    
    assign out = sel? in1 : in0;
    
endmodule // mux2
