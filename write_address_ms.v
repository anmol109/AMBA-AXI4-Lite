module write_address_ms(ACLK, ARESETn, AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);
input ACLK, ARESETn;
input AWREADY, AWVALID;
input [31:0] i_AWADDR;
input [2:0] AWPROT;
output [31:0]o_AWADDR;

wire o_AREADY=1'b0, o_AVALID=1'b0;
wire [31:0] w_AWADDR=32'b0;

write_address_master addr_m(ACLK, ARESETn, AWVALID, o_AWVALID, o_AWREADY, i_AWADDR, w_AWADDR, AWPROT);
write_address_slave addr_s(ACLK, ARESETn, o_AWVALID, AWREADY, o_AWREADY, w_AWADDR, o_AWADDR);

endmodule



module write_address_master(ACLK, ARESETn,i_AWVALID, o_AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);
	input ACLK;
	input ARESETn;
	input i_AWVALID;
	input AWREADY;
	output reg o_AWVALID;
	input [31:0] i_AWADDR;
	output reg [31:0] o_AWADDR;
	input [2:0] AWPROT;         // Check
	
		

	always @(posedge ACLK or posedge ARESETn or i_AWVALID) begin
		if(ARESETn)
		begin
		o_AWADDR <= 32'b0;
		o_AWVALID <=1'b0;
		end
		else if(i_AWVALID)
		begin
		if(i_AWVALID)
		o_AWVALID<=1'b1;
		else
		o_AWVALID<=1'b0;
		end
		
		else begin

		if (o_AWVALID && AWREADY) 
		o_AWADDR <= i_AWADDR;
		
		else 
		o_AWADDR <= 32'b0;
		end
	
	end
endmodule	



module write_address_slave(ACLK,ARESETn, AWVALID, i_AWREADY, o_AWREADY, i_AWADDR, o_AWADDR);
	input ACLK;
	input ARESETn;
	output reg o_AWREADY;
	input i_AWREADY;
	input AWVALID;
	input [31:0] i_AWADDR;
	output reg [31:0] o_AWADDR;
	//input [2:0] AWPROT;         // Check
	
	always @(posedge ARESETn) begin    // RESET
		o_AWADDR <= 32'b0;
		o_AWREADY <=1'b0;
	end
	
	always @(i_AWREADY) begin       //Hand Shaking and addr sending
		if(i_AWREADY)
		o_AWREADY<=1'b1;
		end

	always @(posedge ACLK) begin
		if (AWVALID && o_AWREADY) 
		o_AWADDR <= i_AWADDR;
		
		else 
		o_AWADDR <= 32'b0;
	
	end
endmodule
