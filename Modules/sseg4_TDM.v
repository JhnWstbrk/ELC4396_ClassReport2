`timescale 1ns / 1ps
// John Westbrook, ELC 2137, 11/02/2021


module sseg4_TDM(
    input [15:0] data,
    input hex_dec,
    input sign,
    input reset, clock,
    output [6:0] seg,
    output dp,
    output [3:0] an
    );
    
    // sseg4
    wire [15:0] bcd11_out;
    bin2bcd_11bit bcd11_0(.in(data[10:0]), .out(bcd11_out));
    
    wire [15:0] mux2_0_out;
    mux2 #(.N(16)) mux2_0(.in1(data), .in0(bcd11_out), .sel(hex_dec), .out(mux2_0_out));
    
    wire [3:0] mux4_out;
    mux4 #(.N(4)) mux4_0(.in0(mux2_0_out[3:0]), .in1(mux2_0_out[7:4]), .in2(mux2_0_out[11:8]), .in3(mux2_0_out[15:12]),
            .sel(digit_sel), .out(mux4_out));
            
    wire [6:0] sseg_decoder_out;
    sseg_decoder sseg_0(.num(mux4_out), .sseg(sseg_decoder_out));
    
    // Added for TDM ///////////
    wire [1:0] timer_out;
    counter #(.N(15)) timer(.en(1'b1), .rst(reset), .clk(clock), .tick(timer_out));
    
    wire [1:0] digit_sel;
    counter #(.N(2)) counter2(.en(timer_out), .rst(reset), .clk(clock), .count(digit_sel));
    ////////////////////////////
    
    wire [3:0] an_decoder_out;
    an_decoder an_0(.in(digit_sel), .out(an_decoder_out));
    
    wire mux2_1_sel;
    and(mux2_1_sel, sign, (!an_decoder_out[3]));
    
    mux2 #(.N(7)) mux2_1(.in1(7'b0111111), .in0(sseg_decoder_out), .sel(mux2_1_sel), .out(seg));
    
    assign dp = 1'b1;
    assign an = an_decoder_out;
    
    // Added for TDM
    

endmodule
