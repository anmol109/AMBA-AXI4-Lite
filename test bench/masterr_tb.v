module masterr_tb;
reg ACLK;
reg ARESETn;
reg [31:0] data;
reg ARREADY;
reg RVALID;
reg read;
wire [2:0] ARPROT;
wire o_ARVALID; 
wire o_RREADY;
wire[31:0] o_ARADDR;
wire[1:0] o_RRESP;
wire [31:0] o_RDATA;
reg AWREADY;
reg WREADY;
reg BVALID;
reg write;
wire o_AWVALID;
wire o_WVALID;
wire [31:0] o_WDATA;
wire [31:0] o_AWADDR;
wire [3:0] o_WSTRB;
wire [2:0] AWPROT;
wire o_BREADY;
wire o_BRESP;

master mm(ACLK, ARESETn,ARREADY,RVALID, o_ARVALID,o_RREADY,o_ARADDR,i_RDATA,o_RRESP,ARPROT, read, data,o_RDATA,
AWREADY,WREADY,BVALID,write,o_AWVALID,o_AWADDR,o_WVALID,o_WDATA,o_WSTRB,AWPROT,o_BREADY,o_BRESP);
initial begin
ACLK<=1;
forever #5 ACLK=~ACLK;
end
initial begin
ARESETn<=0;
ARREADY<=0;
RVALID<=0;
read<=0;
data<=32'h11111111;
#20 ARREADY<=1;
#40 RVALID<=1;
#60 read<=1;
write<=0;
AWREADY<=0;
WREADY<=0;
BVALID<=0;
#120 AWREADY<=1;
#120 WREADY<=1;
#100 BVALID<=1;
#100 write<=1;
end
endmodule
