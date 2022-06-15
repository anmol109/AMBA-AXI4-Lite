module write_data_tb;
	reg ACLK;
	reg ARESETn;
	reg WVALID;
	reg[31:0] i_WDATA;
	reg[3:0] WSTRB;
	reg WREADY;
	wire[31:0] o_WDATA;
	
	
	write_data uut(ACLK,ARESETn,WVALID, WREADY, i_WDATA, o_WDATA, WSTRB);
	initial
	begin
	
	i_WDATA = 32'hffffffff;
	#5 WREADY=1'b1;  WVALID=1'b1; WSTRB = 4'B1000;
	#5 WREADY=1'b1;  WVALID=1'b1; WSTRB = 4'B0100;
	#5 WREADY=1'b1;  WVALID=1'b1; WSTRB = 4'B1100;
	#5 WREADY=1'b1;  WVALID=1'b1; WSTRB = 4'B0010;
	#5 WREADY=1'b1;  WVALID=1'b1; WSTRB = 4'B0001;
	#5 WREADY=1'b1;  WVALID=1'b1; WSTRB = 4'B0110;
	#5 WREADY=1'b1;  WVALID=1'b1; WSTRB = 4'B0011;
	#5 WREADY=1'b1;  WVALID=1'b1; WSTRB = 4'B1111;
	#15 $finish;
	end
initial
begin
ACLK=1'b0;
forever #3 ACLK<=~ACLK;
end
endmodule