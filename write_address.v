module write_address(ACLK,ARESETn,AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);
	input ACLK;
	input ARESETn;
	input AWVALID;
	input AWREADY;
	input [31:0] i_AWADDR;
	output reg [31:0] o_AWADDR;
	input [2:0] AWPROT;         // Check
	
	always @(posedge ARESETn) begin    // RESET
		o_AWADDR <= 0;
	end
	
	always @(posedge ACLK) begin       //Hand Shaking and addr sending
		if (AWVALID && AWREADY) begin
			o_AWADDR <= i_AWADDR;
		end
		else o_AWADDR <= 0;
	end
endmodule

			

		

	