`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:25:37 12/08/2017 
// Design Name: 
// Module Name:    blinking 
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
module blinking(
    //input [22:0] disps,
    input clk,
    output [7:0] seven_out,
    output reg [3:0] AN
    );

reg [22:0] disps = 23'b00000001000100001100100;
reg [1:0] count = 0;
reg [8:0] blinkcount = 0;
reg [4:0] seven_in;
wire new_clk;
all_to_segment a1(seven_in,seven_out);	 
clk_divider clk1(clk,reset,new_clk);
//blinkclock clk2(clk,reset,blink_clk);

always @(posedge new_clk) begin

blinkcount = blinkcount + 1;
count <= count + 1;

case(disps[22])
0:
begin

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

1:
begin

case(disps[21:20])

0:
begin

if(blinkcount<400)

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

else

case(count)

	0:
	begin
	AN <= 4'b0111;
	seven_in <= 5'b10001;
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


1:
begin

if(blinkcount<400)

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

else

case(count)

	0:
	begin
	AN <= 4'b0111;
	seven_in <= disps[19:15];
	end

	1:
	begin
	AN <= 4'b1011;
	seven_in <= 5'b10001;
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

2:
begin

if(blinkcount<400)

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

else

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
	seven_in <= 5'b10001;
	end
	
	3:
	begin
	AN <= 4'b1110;
	seven_in <= disps[4:0];
	end
	
endcase
end

3:
begin

if(blinkcount<400)

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

else

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
	seven_in <= 5'b10001;
	end
	
endcase
end //ending begin

endcase //ending first case

end

endcase

end
//ending posedge

endmodule
