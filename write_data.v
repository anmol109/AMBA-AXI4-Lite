module write_data (ACLK, ARESETn,WVALID, WREADY, i_WDATA, o_WDATA, WSTRB);
input ACLK;
input ARESETn;
input WVALID;
input WREADY;
input [31:0] i_WDATA;
output reg [31:0] o_WDATA;
input [3:0] WSTRB;         

reg [31:0] temp_WDATA;
	
	
always @(posedge ARESETn) begin    // RESET
o_WDATA <= 0;
end

always @(WSTRB) begin
temp_WDATA=32'h0;
casex (WSTRB)
4'b1???: temp_WDATA[31:24]=8'b11111111;
4'b?1??: temp_WDATA[23:16]=8'b11111111;
4'b??1?: temp_WDATA[15:8]=8'b11111111;
4'b???1: temp_WDATA[7:0]=8'b11111111;
default:
temp_WDATA=0;
endcase
temp_WDATA=i_WDATA&temp_WDATA;
end


	
always @(posedge ACLK) begin       //Hand Shaking and addr sending
if (WVALID && WREADY) 
o_WDATA <= temp_WDATA;
		
else 
o_WDATA <= 0;
end
	
endmodule	