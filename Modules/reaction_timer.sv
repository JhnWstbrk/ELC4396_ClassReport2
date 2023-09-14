`timescale 1ns / 1ps

module reaction_timer(
input logic clk,
input logic rst,
input logic start,
input logic stop,
input logic clear,
//output logic dp,
output logic [3:0]an,
output logic [6:0] sseg,
output logic led
);
    parameter N = 27;
    //CLEAR: SSEG displays "HI". LED is OFF.
    //START : SSEG turns off. LED will pop on after 5 seconds, SSEG will count from 0 to 1000 ms.
    //User should try to push teh stop button ASAP. 
    //STOP: Timer pauses at last value. 
    
    //If STOP is not pushed, timer stops after 1 second and siplays 10000. IF stop is pushed befpre LED turns on,
    // circuit displays 9999 and stops.
    //If button is pressed,
    
    logic [N-1:0] count;
    logic start_wire;
    logic stop_wire;
    logic clear_wire;
    logic output_wire;
    logic led_on;
    logic timer_start;

    count_n counter(
        .clk(clk),
        .rst(rst),
        .up(up),
        .en(timer_start),
        .tic(tic),
        .count(count));
        
    mux mux_reaction_timer(
    .a(start_wire),
    .b(stop_wire),
    .c(clear_wire),
    .sel({BTND, BTNC, BTNU}),	//2:0 
    .e(output_wire));
    
    always_ff @(posedge clk, posedge output_wire) begin
        reaction_state <= output_wire;
    end

    always_comb begin
        if(reaction_state == start_wire) begin
            an = 4'b1111;
	        #5000;
	        an = 4'b0000;
            led = 1'b1;
            led_on = 1'b1;
	        timer_start = 1'b1;
            //display timer on sseg
            if(reaction_state == stop_wire) begin
             //display last time on the screen
            end
            if(counter == 1000) begin
	           timer_start = 1'b0;
	        end
	    end
        if(reaction_state == stop_wire && led_on != 1'b1) begin
            //display 9999 on sseg
        end
    end
  
endmodule
