module write_data (ACLK, ARESETn,WVALID, WREADY, i_WDATA, o_WDATA, WSTRB);
input ACLK;
input ARESETn;
input WVALID;
input WREADY;
input [31:0] i_WDATA;
output reg [31:0] o_WDATA;
input [3:0] WSTRB;         // Check

wire [31:0] temp_WDATA;
	
	
always @(posedge ARESETn) begin    // RESET
o_WDATA <= 0;
end

always @(i_WDATA) begin
case (WSTRB)

	
always @(posedge ACLK) begin       //Hand Shaking and addr sending
if (WVALID && WREADY) 
o_WDATA <= i_WDATA;
		
else 
o_WDATA <= 0;
end
	
	
wdata = 32'b000zzz
	
	
	
endmodule	