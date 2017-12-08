`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:41:00 12/04/2017 
// Design Name: 
// Module Name:    pretend_top_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pretend_top_module(input clk,
	input reset,
	input clear,
	input enter,
	input change,
	output reg[27:0]ssd,
	output reg[7:0] led,
	input [3:0] switch
    );
	 
	 reg[15:0] password;
	 reg[7:0] current_state;
	 reg[7:0] next_state;
	 reg[3:0] count;
	 reg[3:0] AN;
	 
	 wire [3:0]our_in1;
	 wire [3:0] our_in2;
	 
	 //IN this always block the counter will move up by one whenever enter is clicked
	 //As the counter increases it moves which ssd display is being worked on
	 always@(posedge clk or posedge enter)
	 
	 /*
	 This if statement is running alongside the clock and will increment
	 as each time enter is pressed.
	 */
		if (enter == 1)
			count <= count + 1;
		else
			count <= count;
	   end
	 
	 /*
	 Series of case statements that will shift which portion of the ssd
	 lights up. If we were to make a top module which had a top module
	 that moved between states. So if you designated a code to each state
	 */
	 case(count)
	 0:
		begin
		our_in1 = 4'b0100;
		letter_decoder C(.in(our_in1), );
		our_in2 = 4'b0110;
		letter_decoder D(.in(our_in2), );
		end
	1:
		begin
		num_decoder num1(.a(), .b()
		letter_decoder L(.a(), .b(), .c(), .d(), );
		letter_decoder S(.a(), .b(), .c(), .d(), );
		end
	2:
		begin
		if(clear == 1)
		count = 1;
		else
		letter_decoder dash1(.a(), .b(), .c(), .d(), );
		num_decoder num2(.a(), .b(), .c(), .d(), );
		end
	 endcase


endmodule
