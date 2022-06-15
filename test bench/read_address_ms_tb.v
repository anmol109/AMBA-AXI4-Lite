module read_address_ms_tb;

reg ACLK, ARESETn;
reg ARREADY, ARVALID;
reg [31:0] i_ARADDR;
reg [2:0] ARPROT;

wire [31:0] o_ARADDR;

read_address_ms uut (ACLK, ARESETn, ARVALID, ARREADY,i_ARADDR, o_ARADDR, ARPROT);

initial	begin
i_ARADDR = 32'hffffffff;
#5 ARREADY=1'b0;  ARVALID=1'b1;
#5 ARREADY=1'b1;  ARVALID=1'b1;
#5 ARREADY=1'b1;  ARVALID=1'b1;
#5 ARREADY=1'b1;  ARVALID=1'b1;
#5 ARREADY=1'b1;  ARVALID=1'b0;
#200 $finish;
end
initial begin
ACLK=1'b0;
forever #3 ACLK<=~ACLK;
end
endmodule
