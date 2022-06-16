module slave1(ACLK, ARESETn,ARVALID,RREADY,o_ARREADY,i_ARADDR,o_RVALID,o_RDATA,o_RRESP,read,
write,AWVALID,WVALID,BREADY,i_AWADDR,i_WDATA,i_WSTRB,i_BRESP,o_AWREADY,o_WREADY,o_BVALID,o_BRESP);
input ACLK;
input ARESETn;
//read signals
input ARVALID;
input RREADY;
input read;
output  o_ARREADY; 
output  o_RVALID;
input[31:0] i_ARADDR;
output [31:0] o_RDATA;
output [1:0] o_RRESP;
reg i_ARREADY;
reg i_RVALID;
wire [32:0] o_ARADDR;
reg [32:0] i_RDATA;
reg [31:0] data;

//write signals
input write;
input AWVALID;
input WVALID;
input BREADY;
input [31:0] i_AWADDR;
input [31:0] i_WDATA;
input [3:0] i_WSTRB;
input [1:0] i_BRESP;
output o_AWREADY;
output o_WREADY;
output o_BVALID;
output o_BRESP;
reg i_AWREADY;
reg i_WREADY;
reg i_BVALID;
wire [31:0] o_WDATA; 
wire o_BRESP;

always@(posedge ACLK)
begin
if(ARESETn)
begin
i_ARREADY<=0;
i_RVALID<=0;
end
else
begin 
if(read)//read code
begin
i_ARREADY<=1;
i_RVALID<=1;
i_RDATA<=data;
end
else
begin
i_ARREADY<=0;
i_RVALID<=0;
end
if(write)//write code
begin
i_AWREADY<=1;
i_WREADY<=1;
data<=o_WDATA;
if(BREADY)
i_BVALID<=1; 
else 
i_BVALID<=0;
end

end
end
write_address_slave was(ACLK,ARESETn, AWVALID, i_AWREADY, o_AWREADY, i_AWADDR, o_AWADDR);
write_data_slave wds(ACLK, ARESETn,WVALID, o_WREADY, i_WREADY, i_WDATA, o_WDATA,i_WSTRB, o_WSTRB);
write_response_slave wrs(ACLK, ARESETn,i_BVALID, o_BVALID, BREADY, i_BRESP, o_BRESP);

read_address_slave ras(ACLK, ARESETn, i_ARREADY, o_ARREADY, ARVALID, i_ARADDR, o_ARADDR);
read_data_slave rds(ACLK, ARESETn, i_RVALID, o_RVALID, RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);
endmodule

