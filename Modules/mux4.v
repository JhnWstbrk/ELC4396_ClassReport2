`timescale 1ns / 1ps
// John Westbrook, ELC 2137, 10/12/2021


module mux4 #(parameter N = 1)(
    input [N-1:0] in0,
    input [N-1:0] in1,
    input [N-1:0] in2,
    input [N-1:0] in3,
    input [1:0] sel,
    output reg [N-1:0] out
    );
    
    always @*
        begin
            case (sel)
               2'b00    : out = in0;
               2'b01    : out = in1;
               2'b10    : out = in2;
               2'b11    : out = in3;
            endcase
        end
        
endmodule // mux4
