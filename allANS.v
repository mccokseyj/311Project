module allANS(
    input [15:0] disps,
    input clk,
    output [6:0] seven_out,
    output reg [3:0] AN
    );

reg [1:0] count = 0;
reg [3:0] seven_in;

character_to_segment a1(seven_in,seven_out);

always @(posedge clk) begin
count <= count + 1;

	case(count)
	
	0:
	begin
	AN <= 4'b0111;
	seven_in <= disps[15:12];
	end
	
	1:
	begin
	AN <= 4'b1011;
	seven_in <= disps[11:8];
	end
	
	2:
	begin
	AN <= 4'b1101;
	seven_in <= disps[7:4];
	end
	
	3:
	begin
	AN <= 4'b1110;
	seven_in <= disps[3:0];
	end
	
	endcase
end

endmodule
