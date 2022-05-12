module write_address_ms_tb;
reg ACLK, ARESETn;
reg AWREADY, AWVALID;
reg [31:0] i_AWADDR;
reg [2:0] AWPROT;

wire [31:0]o_AWADDR;

write_address_ms uut(ACLK, ARESETn, AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);

initial	begin
i_AWADDR = 32'hffffffff;
#5 AWREADY=1'b0;  AWVALID=1'b1;
#5 AWREADY=1'b0;  AWVALID=1'b1;
#5 AWREADY=1'b1;  AWVALID=1'b1;
#5 AWREADY=1'b1;  AWVALID=1'b1;
#5 AWREADY=1'b1;  AWVALID=1'b1;
#15 $finish;
end
initial begin
ACLK=1'b0;
forever #3 ACLK<=~ACLK;
end
endmodule