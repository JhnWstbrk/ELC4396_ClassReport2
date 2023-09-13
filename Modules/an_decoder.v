`timescale 1ns / 1ps
// John Westbrook, ELC 2137, 10/12/2021


module an_decoder(
    input [1:0] in,
    output reg [3:0] out
    );
    
    always @*
        begin
            case (in)
                2'b00 : out = 4'b1110;
                2'b01 : out = 4'b1101;
                2'b10 : out = 4'b1011;
                2'b11 : out = 4'b0111;
            endcase
        end
        
endmodule // an_decoder
