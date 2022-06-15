module write_address_slave(ACLK,ARESETn, i_AWREADY, o_AWREADY, AWADDR);
	input ACLK;
	input ARESETn;
	output reg o_AWREADY;
	input i_AWREADY;
	output reg [31:0] AWADDR;
	//input [2:0] AWPROT;         // Check
	
	always @(posedge ARESETn) begin    // RESET
		AWADDR <= 0;
		o_AWREADY <=0;
	end
	
	always @(posedge ACLK) begin       //Hand Shaking and addr sending
		if(i_AWREADY)
		o_AWREADY=1;

		if (write_address_master.o_AWVALID && o_AWREADY) 
		AWADDR <= write_address_master.o_AWADDR;
		
		else 
		AWADDR <= 0;
	
	end
endmodule	