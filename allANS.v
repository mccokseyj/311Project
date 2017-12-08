`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:46:34 12/08/2017 
// Design Name: 
// Module Name:    allANS 
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
module allANS(
	 input [19:0] disps,
    input clk,
    output [7:0] seven_out,
	 //input reset,
    output reg [3:0] AN
    );

	reg [1:0] count = 0;
	reg [4:0] seven_in;
	//reg [19:0]disps = 20'b00000000010000000001;
wire new_clk;
all_to_segment a1(seven_in,seven_out);
clk_divider clk1(clk,reset,new_clk);

always @(posedge new_clk) begin
count <= count + 2'd1;

	case(count)
	
	0:
	begin
	AN <= 4'b0111;
	seven_in <= disps[19:15];
	end
	
	1:
	begin
	AN <= 4'b1011;
	seven_in <= disps[14:10];
	end
	
	2:
	begin
	AN <= 4'b1101;
	seven_in <= disps[9:5];
	end
	
	3:
	begin
	AN <= 4'b1110;
	seven_in <= disps[4:0];
	end
	endcase
end

endmodule