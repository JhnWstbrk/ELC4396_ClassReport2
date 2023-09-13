`timescale 1ns / 1ps
// John Westbrook, ELC 2137, 10/07/2021

module bin2bcd_11bit(
    input [10:0] in,
    output [15:0] out
    );
    
    wire [3:0] c1_out;
    add3 C1(.inbit({1'b0, in[10:8]}), .outbit(c1_out));
    
    wire [3:0] c2_out;
    add3 C2(.inbit({c1_out[2:0], in[7]}), .outbit(c2_out));
    
    wire [3:0] c3_out;
    add3 C3(.inbit({c2_out[2:0], in[6]}), .outbit(c3_out));
    
    wire [3:0] c4_out;
    add3 C4(.inbit({c3_out[2:0], in[5]}), .outbit(c4_out));
    
    wire [3:0] c5_out;
    add3 C5(.inbit({c4_out[2:0], in[4]}), .outbit(c5_out));
    
    wire [3:0] c6_out;
    add3 C6(.inbit({c5_out[2:0], in[3]}), .outbit(c6_out));
    
    wire [3:0] c7_out;
    add3 C7(.inbit({c6_out[2:0], in[2]}), .outbit(c7_out));
    
    wire [3:0] c8_out;
    add3 C8(.inbit({c7_out[2:0], in[1]}), .outbit(c8_out));
    
    
    wire [3:0] c9_out;
    add3 C9(.inbit({1'b0, c1_out[3], c2_out[3], c3_out[3]}), .outbit(c9_out));
    
    wire [3:0] c10_out;
    add3 C10(.inbit({c9_out[2:0], c4_out[3]}), .outbit(c10_out));
    
    wire [3:0] c11_out;
    add3 C11(.inbit({c10_out[2:0], c5_out[3]}), .outbit(c11_out));
    
    wire [3:0] c12_out;
    add3 C12(.inbit({c11_out[2:0], c6_out[3]}), .outbit(c12_out));
    
    wire [3:0] c13_out;
    add3 C13(.inbit({c12_out[2:0], c7_out[3]}), .outbit(c13_out));
    
    
    wire [3:0] c14_out;
    add3 C14(.inbit({1'b0, c9_out[3], c10_out[3], c11_out[3]}), .outbit(c14_out));
    
    wire [3:0] c15_out;
    add3 C15(.inbit({c14_out[2:0], c12_out[3]}), .outbit(c15_out));
    
    assign out[3:0] = {c8_out[2:0], in[0]};
    assign out[7:4] = {c13_out[2:0], c8_out[3]};
    assign out[11:8] = {c15_out[2:0], c13_out[3]};
    assign out[15:12] = {2'b00, c14_out[3], c15_out[3]};
    
endmodule // bin2bcd_11bit
