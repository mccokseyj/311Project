`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:05:03 12/06/2017 
// Design Name: 
// Module Name:    DFF_Module 
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
module DFF_Module(
    input [3:0] D,
 	 input clk,
 	 input rst,
 	 output reg [3:0] PasswordStorage
 	 );
 	 
 	 //Specifying how the asynchronus DFF will operate.
 	 always @(posedge clk or posedge rst)
 	 if (rst)
 		begin
 			PasswordStorage <= 4'b0;
 		end
 	 else
 		begin
 			PasswordStorage <= D;
 		end
 
 
 endmodule