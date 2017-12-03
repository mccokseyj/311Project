`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:52:52 12/02/2017 
// Design Name: 
// Module Name:    ssd 
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
module ssd(
    input clk,
    input enter,
    input [3:0] switch_test,
	 input [3:0] AN_in,
    output reg [3:0] AN,
    output [7:0] seven_out
    );

initial AN = 4'b0111;
reg [3:0] seven_in;
reg [1:0] count = 0;

binary_to_segment disp0(seven_in,seven_out);

always @(posedge clk) begin

	AN <= 4'b0111;
	seven_in <= switch_test;
	
end

endmodule
