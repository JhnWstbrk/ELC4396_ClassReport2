`timescale 1ns / 1ps
// John Westbrook, ELC 2137, 10/05/2021


module add3(
    input [3:0] inbit,
    output reg [3:0] outbit
    );
    
    always @*
        begin
            if (inbit >= 5)
                outbit = inbit + 3;
            else
                outbit = inbit;
        end
       
endmodule // add3.v
