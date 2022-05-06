module write_address(ACLK,ARESETn,AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);
	input ALCK;
	input ARESETn;
	input AWVALID;
	input AWREADY;
	input [31:0] i_AWADDR;
	output reg [31:0] o_AWADDR;
	input [2:0] AWPROT;         // Check
	
	always @(posedge ARESETn) begin    // RESET
		AWREADY <= 0;
	
	
	always @(posedge ACLK) begin       //Hand Shaking and addr sending
		if (AWVALID and AWREADY) begin
			o_AWADDR <= i_AWADDR;
		end
	end
			
	