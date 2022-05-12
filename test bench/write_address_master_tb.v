module write_address_master_tb;   //not ready
reg ACLK;
reg ARESETn;
reg i_AWVALID;
reg i_AWREADY;
reg [2:0] AWPROT;         
reg [31:0] i_AWADDR;
wire [31:0] o_AWADDR;
wire o_AWVALID;
wire o_AWREADY;

write_address_master uut1(ACLK,ARESETn,i_AWVALID, o_AWVALID, i_AWADDR, o_AWADDR, AWPROT);
write_address_slave uut2(ACLK,ARESETn, i_AWREADY, o_AWREADY, o_AWADDR);

initial	begin
i_AWADDR = 32'hffffffff;
#5 i_AWREADY=1'b0;  i_AWVALID=1'b1;
#5 i_AWREADY=1'b0;  i_AWVALID=1'b1;
#5 i_AWREADY=1'b1;  i_AWVALID=1'b1;
#5 i_AWREADY=1'b1;  i_AWVALID=1'b1;
#5 i_AWREADY=1'b1;  i_AWVALID=1'b1;
#15 $finish;
end
initial begin
ACLK=1'b0;
forever #3 ACLK<=~ACLK;
end
endmodule