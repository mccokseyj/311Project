`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:14 12/07/2017 
// Design Name: 
// Module Name:    password_entry_counter 
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
module password_entry_counter(
    input new_clk,
    input [3:0] switch_test,
	 input clean_enter,
	 output reg [3:0] AN,
    output [7:0] seven_out
    );
	 
//Initializing some values.
reg [3:0] seven_in;
reg [1:0] count = 0;
reg [15:0] allAN = 16'b0111101111011110;

//Implementing the counter.
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

//Adjusting the counter when Enter is pressed.
always @(posedge clean_enter) begin
	if(clean_enter == 1)
		if (count < 3)
			count <= count + 1'b1;
		else
			count <= 0;
end

endmodule
