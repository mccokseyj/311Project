module allANS(
	input [19:0] disps,
    input clk,
    output [6:0] seven_out,
    output reg [3:0] AN
    );

reg [1:0] count = 0;
	reg [4:0] seven_in;

all_to_segment a1(seven_in,seven_out);

always @(posedge clk) begin
count <= count + 1;

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
