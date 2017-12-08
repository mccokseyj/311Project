`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:08 12/08/2017 
// Design Name: 
// Module Name:    testallANS 
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
module testallANS(
    input clk,
    //input disps,
    output [3:0] AN,
    output [7:0] seven_out
    );

reg [19:0] disps = 20'b00000000010000000001;

allANS getstuff(disps,clk,seven_out,AN);

endmodule
