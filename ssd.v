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
    input [3:0] switch_test,
	 input enter,
	 input reset,
    output reg [3:0] AN,
    output [7:0] seven_out
	 //output reg [1:0] count = 0
    );
	 
	 
initial AN = 4'b0111;
reg [3:0] seven_in;
reg [1:0] count = 0;
reg [15:0] allAN = 16'b0111101111011110;
wire clean_enter;
wire new_clk;

clk_divider change_clk(.clk_in(clk), .rst(reset), .divided_clk(new_clk));

debouncer clean(new_clk, reset,enter,clean_enter);
binary_to_segment disp0(seven_in,seven_out);

always @(posedge new_clk) begin
	case(count)
	0:
	begin
	AN <= allAN[15:12];
	seven_in <= switch_test;
	end
	1:
	begin
	AN <= allAN[11:8];
	seven_in <= switch_test;
	end
	2:
	begin
	AN <= allAN[7:4];
	seven_in <= switch_test;
	end
	3:
	begin
	AN <= allAN[3:0];
	seven_in <= switch_test;
	end
	endcase
end

always @(posedge enter)
begin
		count <= count + 1;
end

endmodule
