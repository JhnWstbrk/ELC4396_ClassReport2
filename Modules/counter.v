`timescale 1ns / 1ps
// John Westbrook, ELC 2137, 11/02/2021

module counter #(parameter N = 1)
(
input clk, rst, en,
output [N-1:0] count,
output tick
);

// internal signals
reg [N-1:0] Q_reg, Q_next;

// register (state memory)
always @ (posedge clk, posedge rst)
begin
    if (rst)
        Q_reg <= 0;
    else
        Q_reg <= Q_next;
end

// next - state logic
always @*
begin
    if (en)
        Q_next = Q_reg + 1;
    else
        Q_next = Q_reg; // no change
end

// output logic
assign count = Q_reg;
assign tick = (Q_reg =={N{1'b1}}) ? 1'b1 : 1'b0;

endmodule // counter
