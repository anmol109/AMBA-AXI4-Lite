module write_address_master(ACLK,ARESETn,i_AWVALID, o_AWVALID, i_AWADDR, o_AWADDR, AWPROT);
	input ACLK;
	input ARESETn;
	input i_AWVALID;
	output reg o_AWVALID;
	input [31:0] i_AWADDR;
	output reg [31:0] o_AWADDR;
	input [2:0] AWPROT;         // Check
	
	always @(posedge ARESETn) begin    // RESET
		o_AWADDR <= 0;
		o_AWVALID <=0;
	end
	
	always @(posedge ACLK) begin       //Hand Shaking and addr sending
		if(i_AWVALID)
		o_AWVALID=1;

		if (o_AWVALID && write_address_slave.AWREADY) 
		o_AWADDR <= i_AWADDR;
		
		else 
		o_AWADDR <= 0;
	
	end
endmodule	