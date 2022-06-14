module write_data_ms(ACLK, ARESETn,WVALID, WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB);
input ACLK, ARESETn;
input WVALID, WREADY;
input [31:0] i_WDATA;
input [3:0] i_WSTRB;  
output [3:0] o_WSTRB;
output [31:0] o_WDATA;
wire o_WVALID, o_WREADY;
wire [3:0] w_WSTRB;
wire [31:0] w_WDATA;

write_data_master data1(ACLK, ARESETn,WVALID,o_WVALID, o_WREADY, i_WDATA, w_WDATA, i_WSTRB, w_WSTRB);
write_data_slave data2(ACLK, ARESETn,o_WVALID, o_WREADY, WREADY, w_WDATA, o_WDATA, w_WSTRB, o_WSTRB);


endmodule


module write_data_master (ACLK, ARESETn,i_WVALID,o_WVALID, WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB);
input ACLK;
input ARESETn;
input i_WVALID;
input WREADY;
input [31:0] i_WDATA;
input [3:0] i_WSTRB;  
output reg [3:0] o_WSTRB; 
output reg o_WVALID;  
output reg [31:0] o_WDATA;    

reg [31:0]temp_WDATA;
	

always @(*) 
begin
if (i_WVALID && WREADY) 
o_WDATA <= temp_WDATA;		
else 
o_WDATA <= 32'b0;


if(ARESETn)
begin    // RESET
o_WDATA <= 32'b0;
o_WVALID <=1'b0;
end

if(i_WVALID)
o_WVALID<=1'b1;
else
o_WVALID<=1'b0;


o_WSTRB=i_WSTRB;

case (i_WSTRB)
4'b1111: temp_WDATA = 32'hffffffff;
4'b1110: temp_WDATA = 32'hffffff00;
4'b1101: temp_WDATA = 32'hffff00ff;
4'b1100: temp_WDATA = 32'hffff0000;
4'b1011: temp_WDATA = 32'hff00ffff;
4'b1010: temp_WDATA = 32'hff00ff00;
4'b1001: temp_WDATA = 32'hff0000ff;
4'b1000: temp_WDATA = 32'hff000000;
4'b0111: temp_WDATA = 32'h00ffffff;
4'b0110: temp_WDATA = 32'h00ffff00;
4'b0101: temp_WDATA = 32'h00fff00f;
4'b0100: temp_WDATA = 32'h00ff0000;
4'b0011: temp_WDATA = 32'h0000ffff;
4'b0010: temp_WDATA = 32'h0000ff00;
4'b0001: temp_WDATA = 32'h000000ff;
4'b0000: temp_WDATA = 32'hff000000;
default: temp_WDATA=0;
endcase

/*if (o_WSTRB == 4'b1xxx) temp_WDATA[31:24]=8'b11111111;
if (o_WSTRB == 4'bx1xx) temp_WDATA[23:16]=8'b11111111;
if (o_WSTRB == 4'bxx1x) temp_WDATA[15:8]=8'b11111111;
if (o_WSTRB == 4'bxxx1) temp_WDATA[7:0]=8'b11111111;
else temp_WDATA=0;*/

temp_WDATA=i_WDATA&temp_WDATA;
end
	
	
endmodule	


module write_data_slave (ACLK, ARESETn,WVALID, o_WREADY, i_WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB);
input ACLK;
input ARESETn;
input WVALID;
input i_WREADY;
input [31:0] i_WDATA;
input [3:0] i_WSTRB;  
output reg o_WREADY;
output reg [31:0] o_WDATA;       
output reg [3:0] o_WSTRB;
//reg [31:0] temp_WDATA;
	
	
always @(*) begin 
if(ARESETn)
begin    // RESET
o_WDATA <= 0;
o_WREADY <= 0;
o_WSTRB <= 0;
end 

else if(i_WREADY)
o_WREADY<=1;
     //Hand Shaking and data sending
else if (o_WREADY && WVALID) 
o_WDATA <= i_WDATA;		
else begin
o_WDATA <= 0;
o_WSTRB <= i_WSTRB; 
end
end

	
endmodule	