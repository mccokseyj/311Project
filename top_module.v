`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:21 12/08/2017 
// Design Name: 
// Module Name:    top_module 
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
module top_module(
	input clk,
	input reset,
	input clear,
	input enter,
	input change,
	output reg[27:0]ssd,
	output reg[7:0]led,
	input [3:0]switches
    );
	 reg[15:0] password;
	 reg[7:0] current_state;
	 reg[7:0] next_state;	//there can be more registers
	 
	 //state transtions
	 always@(posedge clk or posedge reset)
		begin
		if (reset)
			current state <= 0;
		else
		current_state <= current_state;
		end
			
	 begin
	 end
	 
	 //next state definition
	 always@(posedge enter)
	 begin
	 end
	 
	 //control registers
	 alwyas@(posedge clk or posedge reset)
	 begin
	 end
	 
	 //outputs
	 alwyas@(posedge clk or posedge reset)
	 begin
	 end
	
	//there can be more alwyas bolcks

endmodule
