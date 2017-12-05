`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:24:08 12/02/2017 
// Design Name: 
// Module Name:    TFF_Module 
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
module TFF_Module(
	input [3:0] T,
	input clk,
	input rst,
	output [3:0] store
    );
wire [3:0] wxor;

assign wxor[0] = T[0] ^ store[0];
assign wxor[1] = T[1] ^ store[1];
assign wxor[2] = T[2] ^ store[2];
assign wxor[3] = T[3] ^ store[3];
DFF_Module DFF0(.D(wxor), .clk(clk), .rst(rst), .PasswordStorage(store));
endmodule
