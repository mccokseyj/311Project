module ASM (input clk,
    input rst,
	 input rst2,
    input clr,
    input ent,
    input change,
//	output reg [5:0] led,
	output [3:0] AN,
	output [7:0] seven_out,
    input [3:0] sw); 


//registers

 reg [22:0] disps;
 reg [15:0] password; 
 reg [15:0] inpassword;
 reg [15:0] changepassword1;
 reg [15:0] changepassword2;
 reg[5:0] current_state;
 reg [5:0] next_state;
 reg [1:0]count_lock_unlock;
 reg count_changepass;

// parameters for States, you will need more states obviously
parameter IDLE = 6'b000000; //idle state 
parameter GETFIRSTDIGIT = 6'b000001; // get_first_input_state // this is not a must, one can use counter instead of having another step, design choice
parameter GETSECONDDIGIT = 6'b000010; //get_second input state
parameter GETTHIRDDIGIT = 6'b000011;//get thrid input state
parameter GETFOURTHDIGIT = 6'b000100;//get fourth state
parameter UNLOCKED = 6'b000101; //unlocked state
parameter CHANGE = 6'b000110; //If the user is changing the password
parameter CHANGEFIRSTDIGIT = 6'b000111; //change ths firs input for the password
parameter CHANGESECONDDIGIT = 6'b001000; //change the second input for the password
parameter CHANGETHIRDDIGIT = 6'b001001; //change the third input for the password
parameter CHANGEFOURTHDIGIT = 6'b001010; //change the fourth input for the password
parameter LOCKED = 6'b001011; // the locked mode
parameter CHECKPASSWORD = 6'b001100; // give time to read the full password
parameter OLD = 6'b001101; // display old for 1Hz
parameter NEW = 6'b001110; //display neu for 1Hz
parameter RENEW = 6'b001111; //display rneu for 1Hz
parameter SUCC = 6'b010000; // display succ for 1Hz
parameter UNSUCC = 6'b010001; //display usuc for 1Hz
parameter COMPARECHANGE = 6'b010010; //will compare the two new passward and if they are the same, set teh new password
// parameters for output, you will need more obviously
parameter one = 5'd1; //1
parameter two = 5'd2; //2
parameter three = 5'd3; //3
parameter dash = 5'd16;//Display Dashes
parameter blank = 5'd17; //Display "blanks"
parameter O = 5'd18; //O			
parameter P = 5'd19; //P	
parameter E = 5'd20; //E	
parameter n = 5'd21; //n	
parameter C = 5'd22; //C
parameter L = 5'd23; //L
parameter S = 5'd24; //S
parameter d = 5'd25; //d
parameter u = 5'd26; //u
parameter r = 5'd27; //r
parameter t = 5'd28; //t
parameter y = 5'd29; //y

//instantiate the clk divider
wire new_clk;
clk_divider clk1(clk,rst,new_clk);

//debouncers
wire clean_ent;
debouncer enter(new_clk,rst,ent,clean_ent);
wire clean_clr;
debouncer clear(new_clk,rst,clr,clean_clr);
wire clean_change;
debouncer changes(new_clk,rst,change,clean_change);

//Sequential part for state transitions
	always @ (posedge new_clk or posedge rst2)
	begin
		// your code goes here
		if(rst2==1)
		current_state<= IDLE;
		else
		current_state<= next_state;
		
	end



	// combinational part - next state definitions
	always @ (*)
	begin
		if (rst2 == 1)
		begin
			next_state = IDLE;
		end
		else
		begin
			if(current_state == IDLE)	//closed state
			begin
				//assign password[15:0]=16'b0000000000000000;
				// your code goes here
				if(clean_ent == 1)
				begin
					next_state = GETFIRSTDIGIT;
				end
				else
				begin
					next_state = current_state;
				end
			end


			else if ( current_state == GETFIRSTDIGIT ) //input for first digit
			begin
				if (clean_clr == 1)
				begin
					next_state = GETFIRSTDIGIT;
				end
				else
				begin
					if (clean_ent == 1)
					begin
						next_state = GETSECONDDIGIT;
					end
					else
					begin
						next_state = current_state;
					end
				end
			end
		
			else if (current_state == GETSECONDDIGIT) //input for second digit
			begin
				if (clean_clr == 1)
				begin
					next_state = GETFIRSTDIGIT;
				end
				else
				begin
					if (clean_ent == 1)
					begin
						next_state = GETTHIRDDIGIT;
					end
					else
					begin
						next_state = current_state;
					end
				end
			end
				
			else if (current_state == GETTHIRDDIGIT) //input for third digit
			begin
				if (clean_clr == 1)
				begin
					next_state = GETFIRSTDIGIT;
				end
				else
				begin
					if (clean_ent == 1)
					begin
						next_state = GETFOURTHDIGIT;
					end
					else
					begin
						next_state = current_state;
					end
				end
			end
		
			else if (current_state == GETFOURTHDIGIT) //input for fourth digit, decides whether to go to IDLE or UNLOCKED
			begin
				if (clean_clr == 1)
				begin
					next_state = GETFIRSTDIGIT;
				end
				else
				begin
					if (clean_ent == 1)
					begin
						next_state = CHECKPASSWORD;
					end
					/*
						if (count_lock_unlock == 0)	//the program is coming from the IDLE state
						begin
							if (password == inpassword)
							begin
								next_state = UNLOCKED; // if the inputed password is correct
							end
							else
							begin
								next_state = LOCKED; // if the inputed password is incorrect
							end
						end
						else if (count_lock_unlock == 1) //the program is coming from the UNLOCKED state
						begin
							if (password == inpassword)
							begin
								next_state = LOCKED; // if the inputed password is correct
							end
							else
							begin
								next_state = UNLOCKED; // if the inputed password is incorrect
							end
						end
						else
						begin
							next_state = LOCKED;
						end
						*/
					else
					begin
						next_state = current_state;
					end
				end
			end
			
			else if(current_state == CHECKPASSWORD)
			begin
				if (count_lock_unlock == 0)	//the program is coming from the IDLE state
				begin
					if (password == inpassword)
					begin
						next_state = UNLOCKED; // if the inputed password is correct
					end
					else
					begin
						next_state = LOCKED; // if the inputed password is incorrect
					end
				end
				else if (count_lock_unlock == 1) //the program is coming from the UNLOCKED state
				begin
					if (password == inpassword)
					begin
						next_state = LOCKED; // if the inputed password is correct
					end
					else
					begin
						next_state = UNLOCKED; // if the inputed password is incorrect
					end
				end
				else if(count_lock_unlock == 2)
				begin
					if(password == inpassword)
					begin
						next_state = NEW;
					end
					else
					begin
						next_state = UNLOCKED;
					end
				end
				else
				begin
					next_state = LOCKED;
				end
			end
						
			else if (current_state == UNLOCKED) //when the state is UNLOCKED the user puches a button to determine if he locks the system or changes the password
			begin
				if(clean_ent == 1)
				begin
					next_state = GETFIRSTDIGIT;
				end
				else if(clean_change == 1)
				begin
					next_state = OLD;
				end
				else
				begin
					next_state = current_state;
				end
			end
				
			else if (current_state == CHANGEFIRSTDIGIT) // changes the first digit of the password
			begin
				if(clean_ent == 1)
				begin
					next_state = CHANGESECONDDIGIT;
				end
				else
				begin
					next_state = current_state;
				end
			end
				
			else if (current_state == CHANGESECONDDIGIT) // changes the second digit of the password
			begin
				if (clean_clr == 1)
				begin
					next_state = CHANGEFIRSTDIGIT;
				end
				else
				begin
					if(clean_ent == 1)
					begin
						next_state = CHANGETHIRDDIGIT;
					end
					else
					begin
						next_state = current_state;
					end
				end
			end
				
			else if (current_state == CHANGETHIRDDIGIT) //chnages the thrid digit of the password
			begin
				if (clean_clr == 1)
				begin
					next_state = CHANGEFIRSTDIGIT;
				end
				else
				begin
					if (clean_ent == 1)
					begin
						next_state = CHANGEFOURTHDIGIT;
					end
					else
					begin
						next_state = current_state;
					end
				end
			end
				
			else if (current_state == CHANGEFOURTHDIGIT) //changes the fourth digit and moves back to unlocked mode
			begin
				if (clean_clr == 1)
				begin
					next_state = CHANGEFIRSTDIGIT;
				end
				else
				begin
					if (clean_ent == 1)
					begin
						if (count_changepass == 0)
						begin
							next_state = RENEW;
						end
						else if(count_changepass == 1)
						begin
							next_state == CHANGECOMPARE;
						end
					end
					else
					begin
						next_state = current_state;
					end
				end
			end
						
			else if (current_state == LOCKED) //moves from the locked state to the get first digit state
			begin
				if (clean_ent == 1)
				begin
					next_state = GETFIRSTDIGIT;
				end
				else
				begin
					next_state = current_state;
				end
			end
			
			else if (current_state == OLD) //displays old and then sends the state to get first digit
			begin
				if (time_counter1 == new_clk400)//make a new name for this, is it equal to 400
				begin
					next_state = GETFIRSTDIGIT;
				end
				else
				begin
					next_state = current_state;
				end
			end
			
			else if (current_state == NEW) 	//This state will display neu and then send the state to change first digit
			begin
				if (time_counter2 == new_clk400)
				begin
					next_state = CHANGEFIRSTDIGIT;
				end
				else
				begin
					next_state = current_state;
				end
			end
			
			else if(current_state == RENEW)	//this state will display neu and then send the state back to change first digit
			begin
				if (time_counter3 == new_clk400)
				begin
					next_state = CHANGEFIRSTDIGIT;
				end
				else
				begin
					next_state = current_state;
				end
			end
			
			else if(current_state == SUCC)	//in this state the user will be told that they entered the correct new password twice and that the new password has been set.
			begin
				if (time_counter4 == new_clk400) //After the counter has been reached then the user will be returned to the unlocked state
				begin
					next_state = UNLOCKED;
				end
				else
				begin
					next_state = current_state;
				end
			end
			
			else if(current_state == UNSUCC) // in this state the user will be told that they entered the new password incorrectly and that the password has not been changed
			begin
				if(time_counter5 == newclk400) // they will then be taken to the unlocked state
				begin
					next_state = UNLOCKED;
				end
				else
				begin
					next_state = current_state;
				end
			end
			
			else if (current_state == COMPARECHANGE)  //in this state the two passwords that the user inputed will be compared and if they are the same it is a success
			begin
				if(changepassword1 == changepassword2) //otherwise it is unsuccesul, these tow state are called respectivly
				begin
					next_state = SUCC;
				end
				else
				begin
					next_state = UNSUCC;
				end
			end
			
			else
			begin
				next_state = current_state;
			end
		end
	end



	 //Sequential part for control registers, this part is responsible from assigning control registers or stored values
	always @ (posedge new_clk or posedge rst2)
	begin
		if(rst2)
		begin
			inpassword[15:0]=16'd0; // password which is taken coming from user, 
			password[15:0]=16'd0; //set teh password to be zeros
			count_lock_unlock = 2'b00;
		end

		else 
			if(current_state == IDLE)
			begin
			 	password[15:0] = 16'b0000000000000000; // Built in reset is 0, when user in IDLE state.
				 // you may need to add extra things here.
				 count_lock_unlock = 2'b00;
			end
		
			else if(current_state == GETFIRSTDIGIT)
			begin
				if(clean_ent==1)
					inpassword[15:12]=sw[3:0]; // inpassword is the password entered by user, first 4 digin will be equal to current switch values
			end

			else if (current_state == GETSECONDDIGIT)
			begin

				if(clean_ent==1)
					inpassword[11:8]=sw[3:0]; // inpassword is the password entered by user, second 4 digit will be equal to current switch values
			end
			
			else if (current_state == GETTHIRDDIGIT)	//set the next 4 bits of inpassword
			begin
				if (clean_ent == 1)
					inpassword[7:4] = sw[3:0];
					
			end
			
			else if (current_state == GETFOURTHDIGIT) //set the last four bits of inpassword
			begin
				if (clean_ent == 1)
					inpassword[3:0] = sw[3:0];
			end
			
			else if (current_state == UNLOCKED) //change the count value to 1 so that the next time the loop runs it preforms the correct oporation
			begin
				count_lock_unlock = 2'b01;
			end
					
			
			else if (current_state == CHANGEFIRSTDIGIT) //change the first value of a temporary password
			begin
				if (clean_ent == 1)
					changepassword[15:12]=sw[3:0];
			end
			
			else if (current_state == CHANGESECONDDIGIT) // change the second value of a temporary password
			begin
				if (clean_ent == 1)
					changepassword[11:8]=sw[3:0];
			end
			
			else if (current_state == CHANGETHIRDDIGIT) // change the third value of a temporary password
			begin
				if (clean_ent == 1)
					changepassword[7:4]=sw[3:0];
			end

			else if (current_state == CHANGEFOURTHDIGIT) // change the fourth value of a temporary password
			begin
				if (clean_ent == 1)
					if (count_changepass == 0)
					begin
						changepassword1[3:0]=sw[3:0];
					end
					else if (count_changepass == 1)
					begin
						changepassword2[3:0] = sw[3:0];
					end
					
			end

			else if (current_state == LOCKED) // change the count in the locked state to ensure the proper operation
			begin
			count_lock_unlock = 2'b00;
			end
			
			else if(current_state == CHECKPASSWORD) //give time to check the password
			begin
			end
			
			else if(current_state == OLD) //display old for a period of time
			begin
				//a counter will be running here
				count_lock_unlock = 2'b10;
			end
			
			else if(current_state == NEW) //display neu for a period of time and define which temperary password will be used
			begin
				//a counter will be running here
				count_changepass = 1'b0;
			end
			
			else if(current_state == RENEW) //display rneu for a period of time and change the counter to ensure that a different temp password is used
			begin
				//a counter will be running here
				count_changepass = 1'b1;
			end
			
			else if(current_state == SUCC) //display succ for a period of time and change the password to be equal to the user input
			begin
				//a counter will be running here
				password = changepassword1;
			end
			
			else if(current_state == UNSUCC) //display unsuc for a period of time and do not change the password
			begin
				//a counter will be running here
				password = password;
			end
			
			else if(current_state == COMPARECHANGE)
			begin
				//a brief period of time to make sure all of the input is compared
			end

		/*

		Complete the rest of ASM chart, in this section, you are supposed to set the values for control registers, stored registers(password for instance)
		number of trials, counter values etc... 

		*/

	end


	// Sequential part for outputs; this part is responsible from outputs; i.e. SSD and LEDS


blinking blink(disps,clk,seven_out, rst, AN); //This outputs to our ssd display and blinks the necessary bit at 1Hz
//These change the disps register by the stored values and swithces to display the various needed ssd displays
	always @(posedge new_clk)
	begin

		if(current_state == IDLE)
		begin
		//disps <= 22'b00010110101111100011001;
		disps <= {3'b000,C, L, S, d};	//CLSD
		end

		else if(current_state == GETFIRSTDIGIT)
		begin
		disps <= {3'b100,1'b0,sw[3:0],blank, blank, blank};
		//disps[22:20] <= 3'b100;	// you should modify this part slightly to blink it with 1Hz. The 0 is at the beginning is to complete 4bit SW values to 5 bit.
		//disps[19:0] <= 20'b10001100011000110001;
		//disps[18:15] <= sw[3:0];
		//disps[19] <= 1'b0;
		end

		else if(current_state == GETSECONDDIGIT)
		begin
		disps <= {3'b101,dash,1'b0,sw[3:0],blank,blank};
		//disps[22:20] <= 3'b101;	// you should modify this part slightly to blink it with 1Hz. 0 after tire is to complete 4 bit sw to 5 bit. Padding 4 bit sw with 0 in other words.	
		//disps[19:0] <= 20'b10001100011000110001;
		//disps[19:15] <= 5'b10000;
		//disps[13:10] <= sw[3:0];
		//disps[14] <= 1'b0;
		end
		
		else if(current_state == GETTHIRDDIGIT)
		begin
		disps <= {3'b110,dash,dash,1'b0,sw[3:0],blank};
		//disps[22:20] <= 3'b110;	// you should modify this part slightly to blink it with 1Hz. 0 after tire is to complete 4 bit sw to 5 bit. Padding 4 bit sw with 0 in other words.	
		//disps[19:0] <= 20'b10001100011000110001;
		//disps[19:10] <= 10'b1000010000;
		//disps[8:5] <= sw[3:0];
		//disps[9] <= 1'b0;
		end
		
		else if(current_state == GETFOURTHDIGIT)
		begin
		disps <= {3'b111,dash,dash,dash,1'b0,sw[3:0]};
		//disps[22:20] <= 3'b111;	// you should modify this part slightly to blink it with 1Hz. 0 after tire is to complete 4 bit sw to 5 bit. Padding 4 bit sw with 0 in other words.	
		//disps[19:0] <= 20'b10001100011000110001;
		//disps[19:5] <= 15'b100001000010000;
		//disps[3:0] <= sw[3:0];
		//disps[4] <= 1'b0;
		end
		
		else if(current_state == UNLOCKED)
		begin
		disps <= {3'b000,O, P, E, n};	//OPEn
		end
		
		else if(current_state == CHANGEFIRSTDIGIT)
		begin
		disps <= {3'b100,1'b0,sw[3:0],blank,blank,blank};
		end
		
		else if(current_state == CHANGESECONDDIGIT)
		begin
		disps <= {3'b101,1'b0,changepassword[15:12],1'b0,sw[3:0],blank,blank};
		end
		
		else if(current_state == CHANGETHIRDDIGIT)
		begin
		disps <= {3'b110,1'b0,changepassword[15:12],1'b0,changepassword[11:8],1'b0,sw[3:0],blank};
		end
		
		else if(current_state == CHANGEFOURTHDIGIT)
		begin
		disps <= {3'b111,1'b0,changepassword[15:12],1'b0,changepassword[11:8],1'b0,changepassword[7:4],1'b0,sw[3:0]};
		end
		
		else if (current_state == LOCKED)
		begin
		disps <= {3'b000,C, L, S, d};
		end
		
		else if (current_state == CHECKPASSWORD)
		begin
		disps <= {3'b000, blank, blank, blank, blank};
		end
		
		else if (current_state == OLD)
		begin
		disps <= {3'b000,blank, O, L, d};
		end
		
		else if (current_state == NEW)
		begin
		disps <= {3'b000,blank, n, E, u};
		end
		
		else if (current_state == RENEW)
		begin
		disps <= {3'b000, r, n, E, u};
		end
		
		else if (current_state == SUCC)
		begin
		disps <= {3'b000, S, u, C, C};
		end
		
		else if (current_state == UNSUCC)
		begin
		disps <= {3'b000, u, n, S, u};
		end
		
		else if (current_state == COMPARECHANGE)
		begin
		disps <= {3'b000,blank, blank, blank, blank};
		end
		
		end
		/*
		 You need more else if obviously

		*/



endmodule