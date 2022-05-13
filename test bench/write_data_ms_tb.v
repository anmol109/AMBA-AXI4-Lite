module write_data_ms_tb;
reg ACLK, ARESETn;
reg WREADY, WVALID;
reg [31:0] i_WDATA;
reg [3:0] i_WSTRB;

wire [3:0] o_WSTRB;
wire [31:0]o_WDATA;

write_data_ms uut(ACLK, ARESETn,WVALID, WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB);

initial	begin
i_WDATA = 32'hffffffff;
i_WSTRB = 4'b1111;
#5 WREADY=1'b0;  WVALID=1'b1; 
#5 WREADY=1'b0;  WVALID=1'b1;
#5 WREADY=1'b0;  WVALID=1'b1;
#5 WREADY=1'b1;  WVALID=1'b1;
#5 WREADY=1'b1;  WVALID=1'b1;
#5 WREADY=1'b1;  WVALID=1'b1;
#20 $finish;
end
initial begin
ACLK=1'b0;
forever #3 ACLK<=~ACLK;
end
endmodule