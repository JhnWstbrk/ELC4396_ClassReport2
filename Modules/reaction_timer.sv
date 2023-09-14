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
    //CLEAR: SSEG displays "HI". LED is OFF.
    //START : SSEG turns off. LED will pop on after 5 seconds, SSEG will count from 0 to 1000 ms.
    //User should try to push teh stop button ASAP. 
    //STOP: Timer pauses at last value. 
    
    //If STOP is not pushed, timer stops after 1 second and siplays 10000. IF stop is pushed befpre LED turns on,
    // circuit displays 9999 and stops.
    //If button is pressed,
    parameter START = 3'b001;
    parameter STOP = 3'b010;
    parameter CLEAR = 3'b100;
    
    logic [N-1:0] count;
//    logic [2:0]start_wire;
//    logic [2:0]stop_wire;
//    logic [2:0]clear_wire;
//    logic [2:0]output_wire;
    logic led_on;
    logic timer_start;
    logic [11:0] timer;
    logic refresh_rate;
    logic [2:0]reaction_state;

    
//    mux#(.N(3)) mux_reaction_timer(
//    .a(start_wire),
//    .b(stop_wire),
//    .c(clear_wire),
//    .sel({clear, stop, start}),	//2:0 // 0 0 0
//    .e(output_wire));
    
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
    
    always_ff @(posedge clk) begin
        if(start)
            reaction_state <= START;
        else if(stop)
            reaction_state <= STOP;
        else if(clear)
            reaction_state <= CLEAR;
        else
            reaction_state <= 3'b000;
     
       // reaction_state <= output_wire;
    end

    always_comb begin
        if(reaction_state == START) begin
            //an = 4'b1111;
	        #5000;
	        //an = 4'b0000;
            led = 1'b1;
            led_on = 1'b1;
	        timer_start = 1'b1;
        
        end    //display timer on sseg
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
            //display 9999 on sseg
           // timer = 12'd9999;
        end
        if(reaction_state == CLEAR) begin
            led = 1'b0;
          //  timer = 0;
        end
    end
    
    assign an[7:4] = 4'b1111;
    
endmodule

//    count_n counter(
//        .clk(clk),
//        .rst(rst),
//        .up(up),
//        .en(timer_start),
//        .tic(tic),
//        .count(count));