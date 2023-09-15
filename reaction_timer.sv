`timescale 1ns / 1ps

module reaction_timer(
input logic clk,
input logic rst,
input logic start,
input logic stop,
input logic clear,
//input logic BTNC, BTNU, BTND,
input logic [15:0] SW,
//output logic dp,
output logic [7:0]an,
output logic [7:0] sseg,
output logic led,
output logic [15:0] LED
);
    parameter N = 27;
    parameter START = 3'b001;
    parameter STOP = 3'b010;
    parameter CLEAR = 3'b100;
    
    logic [N-1:0] count;

    logic led_on;
    logic timer_start;
    logic [11:0] timer;
    logic refresh_rate;
    logic [2:0]reaction_state;
    logic clear_wire;
    logic [3:0] random;
    logic delay;
    logic end_delay;
    logic display_wire;

    sseg4_TDM uutd(
        .clock(clk),
        .reset(rst),
        .data({4'b0000,timer}),
        .hex_dec(SW[15]),
        .sign(SW[14]),
        .seg(sseg[6:0]),
        .dp(sseg[7]),
        .an(an[3:0]));
    
    count_n# (.N(10)) counter(
        .clk(refresh_rate),
        .rst(rst),
        .en(timer_start),
        .up(1'b1),
        .count(timer));
        
    count_n# (.N(16)) refresh(
        .clk(clk),
        .rst(rst),
        .en(timer_start),
        .up(1'b1),
        .tic(refresh_rate));
    count_delay# (.N(27)) delay_counter(
        .clk(clk),
        .rst(rst),
        .en(delay),
        .up(1'b1),
        .tic(end_delay));
        
    always_ff @(posedge clk) begin
//        if(rst)
//            display_wire <= "HI";
        if(start)
            reaction_state <= START;
        else if(stop)
            reaction_state <= STOP;
        else if(clear)
            reaction_state <= CLEAR;
        else
            reaction_state <= 3'b000;
    end

    always_comb begin
        if(reaction_state == START) begin
              led = 1'b1;
              led_on = 1'b1;
               timer_start = 1'b1;
        end    
        if(reaction_state == STOP && timer_start == 1'b1) begin
             //display last time on the screen
            timer_start = 1'b0;
            led = 1'b0;
        end
        if(timer == 1000) begin
	        timer_start = 1'b0;
	        led = 1'b0;
	    end
	    
        if(reaction_state == STOP && led_on != 1'b1) begin
            
        end
        if(reaction_state == CLEAR || rst == 1'b1) begin
            led = 1'b0;
            
        end
    end
    
    assign an[7:4] = 4'b1111;

endmodule

