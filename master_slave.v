module master_slave(ACLK,ARESETn,write,read,data,o_RDATA);

input ACLK;
input ARESETn;
input write;
input read;
input [31:0] data;
output[31:0] o_RDATA;
wire [31:0] RDATA;
wire [31:0]WDATA;
wire [31:0]AWADDR;
wire [31:0]ARADDR;
wire[3:0] WSTRB;
wire [2:0] AWPROT;
wire [2:0] ARPROT;
wire [1:0]o_RRESP;
wire [1:0] BRESP;
wire [1:0] o_BRESP;
wire ARREADY,RVALID, ARVALID,RREADY,
AWREADY,WREADY,BVALID,AWVALID,WVALID,BREADY;

master mt(ACLK, ARESETn,ARREADY,RVALID, ARVALID,RREADY,ARADDR,RDATA,o_RDATA,o_RRESP,ARPROT, read, data,
AWREADY,WREADY,BVALID,write,AWVALID,AWADDR,WVALID,WDATA,WSTRB,AWPROT,BREADY,BRESP);

slave1 st(ACLK, ARESETn,ARVALID,RREADY,ARREADY,ARADDR,RVALID,RDATA,o_RRESP,read,
write,AWVALID,WVALID,BREADY,AWADDR,WDATA,WSTRB,BRESP,AWREADY,WREADY,BVALID,o_BRESP);

endmodule