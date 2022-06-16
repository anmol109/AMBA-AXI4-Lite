module master_tb;

reg ACLK;
reg ARESETn;
reg [31:0] data;

//read signals

reg ARREADY;
reg RVALID;
reg read;
wire [2:0] ARPROT;
wire o_ARVALID; 
wire o_RREADY;
wire[31:0] o_ARADDR;
reg [31:0] i_RDATA;
wire[1:0] o_RRESP;
reg i_ARVALID;
reg i_RREADY;
reg [31:0] i_ARADDR;
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
reg i_AWVALID;
reg [31:0] i_AWADDR;
reg i_WVALID;
reg i_WDATA;
reg [3:0] i_WSTRB;
reg[1:0] i_BRESP;
reg i_BREADY;

initial begin 

AWREADY = 1'b0;
WREADY = 1'b0;
BVALID = 1'b0;
write = 1'b0;
data = 32'hffffffff;

#5 write = 1'b1;
#5  AWREADY = 1'b1; 
#50 WREADY = 1'b1;
#50 BVALID = 1'b1;
#500 $finish;

end

initial begin
ACLK = 1'b0;
forever #5 ACLK = ~ACLK;
end

endmodule












