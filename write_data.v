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
temp_WDATA=0;
case (WSTRB)
1'bxxx1:
temp_WDATA[3:0]=4'b1111;
1'bxx1x:
temp_WDATA[7:4]=4'b1111;
1'bx1xx:
temp_WDATA[11:8]=4'b1111;
1'b1xxx:
temp_WDATA[15:12]=4'b1111;
default:
temp_WDATA=0;
endcase
i_WDATA=i_WDATA*temp_WDATA;
end


	
always @(posedge ACLK) begin       //Hand Shaking and addr sending
if (WVALID && WREADY) 
o_WDATA <= i_WDATA;
		
else 
o_WDATA <= 0;
end
	
	
wdata = 32'b000zzz
	
	
	
endmodule	