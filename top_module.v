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
	output [7:0]ssd,
	output reg[7:0]led,
	input [3:0]switches,
	output [3:0]AN
    );
	 reg[15:0] password = 0;
	 reg[15:0] Guess_password;
	 reg[7:0] current_state = 0;
	 reg[7:0] next_state = 0;
	 reg[19:0] ssd_input = 20'b10001100011000110001;//there can be more registers
	 wire clean_enter;
	 
	 //instantiate the ssd module
	 allANS getstuff2(ssd_input,clk,ssd,AN);
	 //instantiate the debouncer
	 debouncer clean_enter1(clk,reset,enter,clean_enter);
	 
	 //state transtions
	 always@(posedge clk or posedge reset)
	 begin
		begin
		if (reset)
			begin
			current_state <= 0;
			Guess_password <= 16'd0;
			password <= 16'd0;
			end
		else
		begin
			current_state <= next_state;
			led <= current_state;
			end
		end
		
		case(current_state)
			0: //closed state
			begin
				ssd_input <= 20'b10110101111100011001;
			end
			1: //enter far left digit
			begin
				ssd_input[19] <= 1'b0;
				ssd_input[18:15] <= switches;
				ssd_input[14:0] <= 15'b100011000110001;
				Guess_password[15:12] <= switches;
			end
			2: //enter center left digit
			begin
				ssd_input[19:15] <= 5'b10000;
				ssd_input[14] <= 1'b0;
				ssd_input[13:10] <= switches;
				ssd_input[9:0] <= 10'b1000110001;
				Guess_password[11:8] <= switches;
			end
			3: //enter center right digit
			begin
				ssd_input[19:10] <= 10'b1000010000;
				ssd_input[9] <= 1'b0;
				ssd_input[8:5] <= switches;
				ssd_input[4:0] <= 5'b10001;
				Guess_password[7:4] <= switches;
			end
			4: //enter far right digit
			begin
				ssd_input[19:5] <= 15'b100001000010000;
				ssd_input[4] <= 1'b0;
				ssd_input[3:0] <= switches;
				Guess_password[3:0] <= switches;
			end
			5: //open state
			begin
				ssd_input <= 20'b10010100111010010101;
			end
			6: //enter far left digit
			begin
				ssd_input[19] <= 1'b0;
				ssd_input[18:15] <= switches;
				ssd_input[14:0] <= 15'b100011000110001;
				Guess_password[15:12] <= switches;
			end
			7: //enter center left digit
			begin
				ssd_input[19:15] <= 5'b10000;
				ssd_input[14] <= 1'b0;
				ssd_input[13:10] <= switches;
				ssd_input[9:0] <= 10'b1000110001;
				Guess_password[11:8] <= switches;
			end
			8: //enter center right digit
			begin
				ssd_input[19:10] <= 10'b1000010000;
				ssd_input[9] <= 1'b0;
				ssd_input[8:5] <= switches;
				ssd_input[4:0] <= 5'b10001;
				Guess_password[7:4] <= switches;
			end
			9: //enter far right digit
			begin
				ssd_input[19:10] <= 15'b100001000010000;
				ssd_input[9] <= 1'b0;
				ssd_input[8:5] <= switches;
				ssd_input[4:0] <= 5'b10001;
				Guess_password[3:0] <= switches;
			end
			10: //start of changing of passwords on the far left bit
			begin
				ssd_input[19] <= 1'b0;
				ssd_input[18:15] <= switches;
				ssd_input[14:0] <= 15'b100011000110001;
				password[15:12] <= switches;
			end
			11: // change the center left bit password
			begin
				ssd_input[19:15] <= 5'b10000;
				ssd_input[14] <= 1'b0;
				ssd_input[13:10] <= switches;
				ssd_input[9:0] <= 10'b1000110001;
				password[11:8] <= switches;
			end
			12: //change the center right bit password
			begin
				ssd_input[19:10] <= 10'b1000010000;
				ssd_input[9] <= 1'b0;
				ssd_input[8:5] <= switches;
				ssd_input[4:0] <= 5'b10001;
				password[7:4] <= switches;
			end
			13: //change the far fight bit password
			begin
				ssd_input[19:10] <= 15'b100001000010000;
				ssd_input[9] <= 1'b0;
				ssd_input[8:5] <= switches;
				ssd_input[4:0] <= 5'b10001;
				password[3:0] <= switches;
			end
		endcase
			
	 end
	 
	 //next state definition
	always@(posedge clean_enter or posedge change)
	begin
		begin
		if (change)
			begin
			if(current_state == 5)
				next_state = 10;
			else
				next_state = next_state;
			end	
		else
		begin
			if (current_state == 4) //if the inputed password is equal to the set password go to the open state, other wise return to the closed state
				begin
				if (password == Guess_password)
					next_state = 5;
				else
					next_state = 0;
				end
			else if (current_state == 9) //if the inputed password is equal to the set password, return to the closed state, otherwise return to the open state
				begin
				if (password == Guess_password)
					next_state = 0;
				else
					next_state = 5;
				end
			else if(current_state == 13)
				next_state = 5;
			else
				next_state = next_state + 1;
			end
		end
		//else if(clear)begin
			//if (current_state < 5)begin
				//next_state = 1;
			//end
			//else if (current_state < 10)begin
				//next_state = 6;
			//end
			//else if (current_state <14)begin
				//next_state = 11;
			//end
	end
	 
	 //control registers
	 //always@(posedge clk or posedge reset)
	 //begin
	 //end
	 
	 //outputs
	 //always@(posedge clk or posedge reset)
	 //begin
	 //end
	 //turn a variable on that 
	//there can be more alwyas bolcks

endmodule
