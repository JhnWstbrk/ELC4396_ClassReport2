`timescale 1ns / 1ps

module count_n#(parameter N=18)(
    input logic clk,
    input logic rst,
    input logic up,
    input logic en,
    output logic tic,
    output logic [N-1:0] count
    );
    
    parameter ZERO = {N,{1'b0}};
    
    logic [N-1:0] counter, next_counter;
    
    always_ff @(posedge clk, posedge rst)
        if(rst)
            counter <= 0;
        else
            counter <= next_counter;
    
    always_comb
        if(en)
            if(up)
                next_counter = counter + 1;
            else
                next_counter = counter - 1;
        else
            next_counter = counter;
          
    
    assign count = counter;
    assign tic = (counter == 1);
endmodule


// set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
