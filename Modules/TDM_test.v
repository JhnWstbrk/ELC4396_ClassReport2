`timescale 1ns / 1ps
// John Westbrook, ELC 2137, 11/09/2021


module TDM_test();
    reg [15:0] data;
    reg hex_dec, sign, reset;
    reg clock = 0;
    wire [6:0] seg;
    wire dp;
    wire [3:0] an;
    
    
    sseg4_TDM tdm_0(.data(data), .hex_dec(hex_dec), .sign(sign), .reset(reset), .clock(clock),
            .seg(seg), .dp(dp), .an(an));
            
    always begin
        clock = !clock;     #5;
    end
    initial begin
        hex_dec = 0; sign = 0; reset = 1;
        data = 16'h0000; #10;
        reset = 0;
        data[7:0] = 8'hAB;
        hex_dec = 1'b0; #10;
        hex_dec = 1'b1; #10;
        data[7:0] = 8'hCD;
        hex_dec = 1'b0; #10;
        sign = 1;
        hex_dec = 1'b1; #10;
        $finish;
    end
   
        

endmodule
