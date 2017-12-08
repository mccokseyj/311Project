`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:50:59 12/04/2017 
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
	 input reset,
	 input enter,
	 output reg [3:0] AN,
    output [7:0] seven_out
    );
	 
//Initializing some values.
reg [4:0] seven_in; //Temporarily holds the 5-bit binary input from switches.
reg [1:0] count = 0; //Initializing the counter to zero.
reg [15:0] allAN = 16'b0111101111011110;

/*
Creating a wire that will carry the signal of the slowed down clock.
*/
wire new_clk;

//Generating the slower clock signal.
clk_divider ChangeClock(.clk_in(clk), .rst(reset), .divided_clk(new_clk));

/*
Creating a wire that will carry the signal from Enter after it
runs through the debouncer. This ensures only a single signal will
be generated when enter is pressed.
*/
wire clean_enter;

//Generating the crisp Enter signal.
debouncer CleanSignal(.clk(new_clk), .rst(reset), .noisy_in(enter), .clean_out(clean_enter));

//Linking the binary input from the switches to the corresponding ssd pattern.
binary_to_segment disp0(seven_in, seven_out);


//Implementing the counter.
always @(posedge new_clk) begin
	case(count)
	0:
		begin
			AN <= allAN[15:12];
			seven_in[3:0] <= switch_test;
		end
	1:
		begin
			AN <= allAN[11:8];
			seven_in[3:0] <= switch_test;
		end
	2:
		begin
			AN <= allAN[7:4];
			seven_in[3:0] <= switch_test;
		end
	3:
		begin
			AN <= allAN[3:0];
			seven_in[3:0] <= switch_test;
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
