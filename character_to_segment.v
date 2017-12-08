`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:47:20 12/04/2017 
// Design Name: 
// Module Name:    character_to_segment 
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
module character_to_segment(
    input [3:0] binary_in,
    output reg [6:0] seven_out
    );

always @(binary_in)
begin
	case(binary_in)								//1 means off and 0 means on
		4'd0: seven_out =7'b0000001;			// OFF status, for 2 middle 7-segments
		4'd1: seven_out =7'b0011000;			//display 1
		4'd2: seven_out =7'b0110000;			//2
		4'd3: seven_out =7'b1101010;			//3
		4'd4: seven_out =7'b0110001;
		4'd5: seven_out =7'b1110001;
		4'd6: seven_out =7'b0100100;
		4'd7: seven_out =7'b1000010;
		4'd8: seven_out =7'b1100011;
		4'd9: seven_out =7'b1111010;
		4'd10: seven_out =7'b1111110;
		4'd11: seven_out =7'b1111111;
		
	endcase
end

endmodule
