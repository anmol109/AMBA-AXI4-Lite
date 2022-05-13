module write_data_master (ACLK, ARESETn,i_WVALID,o_WVALID, WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB);
input ACLK;
input ARESETn;
input i_WVALID;
output reg o_WVALID;
input WREADY;
input [31:0] i_WDATA;
output reg [31:0] o_WDATA;
input [3:0] i_WSTRB;  
output reg [3:0] o_WSTRB;         

reg [31:0] temp_WDATA;
	
	
always @(posedge ARESETn) begin    // RESET
o_WDATA <= 0;
o_WVALID <=0;
end

always @(i_WSTRB) begin

o_WSTRB=i_WSTRB;

temp_WDATA=32'h0;
casex (i_WSTRB)
4'b1???: temp_WDATA[31:24]=8'b11111111;
4'b?1??: temp_WDATA[23:16]=8'b11111111;
4'b??1?: temp_WDATA[15:8]=8'b11111111;
4'b???1: temp_WDATA[7:0]=8'b11111111;
default:
temp_WDATA=0;
endcase
temp_WDATA=i_WDATA&temp_WDATA;
end

always @(i_WVALID) begin       //valid signal high
		if(i_WVALID)
		o_WVALID<=1;
		end
	
always @(posedge ACLK) begin       //Hand Shaking and data sending
if (o_WVALID && WREADY) 
o_WDATA <= temp_WDATA;
		
else 
o_WDATA <= 0;
end
	
endmodule	


module write_data_slave (ACLK, ARESETn,WVALID, o_WREADY, i_WREADY, i_WDATA, o_WDATA, WSTRB);
input ACLK;
input ARESETn;
input WVALID;
output reg o_WREADY;
input i_WREADY;
input [31:0] i_WDATA;
output reg [31:0] o_WDATA;
input [3:0] WSTRB;         

reg [31:0] temp_WDATA;
	
	
always @(posedge ARESETn) begin    // RESET
o_WDATA <= 0;
o_WREADY <=0;
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

always @(i_WREADY) begin       //valid signal high
	if(i_WREADY)
	o_WREADY<=1;
	end
	
always @(posedge ACLK) begin       //Hand Shaking and data sending
if (o_WREADY && WVALID) 
o_WDATA <= temp_WDATA;
		
else 
o_WDATA <= 0;
end
	
endmodule	