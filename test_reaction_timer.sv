`timescale 1ns / 1ps


module test_reaction_timer();
    logic clk;
    logic rst;
    logic start;
    logic stop;
    logic clear;
    logic [15:0]SW;
    logic [7:0]an;
    logic [7:0]sseg;
    logic led;
    logic [15:0]LED;


    reaction_timer uut(
    .clk(clk),
    .rst(rst),
    .start(start),
    .stop(stop),
    .clear(clear),
    .SW(SW),
    .an(an),
    .sseg(sseg),
    .led(led),
    .LED(LED));
 
    
    always #5 clk = ~clk;
    initial begin
    clk = 0;
    end
    initial begin
    rst = 1'b1;
    clear = 1'b1;
    #100;
    rst = 1'b0;
    clear = 1'b0;
    #100;
    start = 1'b1;
    #100;
    start = 1'b0;
    end
    
    initial begin
    start = 1'b1;
    #100
    start = 1'b0;
    rst = 1'b1;
    #100;
    rst = 1'b0;
    end
    
    initial begin
    start = 1'b1;
    #100;
    stop =1'b1;
    start = 1'b0;
    #100;
    rst = 1'b1;
    $finish;
    end
    
    
endmodule
