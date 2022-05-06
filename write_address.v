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
	end
endmodule
module write_address_tb;
	reg ACLK;
	reg ARESETn;
	reg AWVALID;
	reg[31:0] i_AWADDR;
	reg[2:0] AWPROT;
	reg AWREADY;
	wire[31:0] o_AWADDR;
	
	
	write_address uut(ACLK,ARESETn,AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);
	initial
	begin
	
	i_AWADDR = 32'h10;
	#5 AWREADY=1'b0;  AWVALID=1'b1;
	#5 AWREADY=1'b1;  AWVALID=1'b1;
	#5 AWREADY=1'b1;  AWVALID=1'b0;
	#5 $finish;
	end
initial
begin
ACLK=1'b0;
	forever #3 ACLK<=~ACLK;
end
endmodule
			
	