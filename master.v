module master(ACLK, ARESETn,ARREADY,RVALID, o_ARVALID,o_RREADY,o_ARADDR,i_RDATA,o_RDATA,o_RRESP,ARPROT, read, data,
AWREADY,WREADY,BVALID,write,o_AWVALID,o_AWADDR,o_WVALID,o_WDATA,o_WSTRB,AWPROT,o_BREADY,o_BRESP);
input ACLK;
input ARESETn;
input [31:0] data;

//read signals

input ARREADY;
input RVALID;
input read;
output [2:0] ARPROT;
output o_ARVALID; 
output o_RREADY;
output[31:0] o_ARADDR;
input [31:0] i_RDATA;
output[1:0] o_RRESP;
reg i_ARVALID;
reg i_RREADY;
reg [31:0] i_ARADDR;
output [31:0] o_RDATA;
reg [31:0]conv_data;
parameter addr=32'h11111111;
//parameter data=32'h01010101;

//write signals

input AWREADY;
input WREADY;
input BVALID;
input write;
output o_AWVALID;
output o_WVALID;
output [31:0] o_WDATA;
output [31:0] o_AWADDR;
output [3:0] o_WSTRB;
output [2:0] AWPROT;
output o_BREADY;
output o_BRESP;
reg i_AWVALID;
reg [31:0] i_AWADDR;
reg i_WVALID;
reg [31:0] i_WDATA;
reg [3:0] i_WSTRB;
reg[1:0] i_BRESP;
reg i_BREADY;

always@(posedge ACLK)
begin
i_WSTRB<=4'b1111;



if(ARESETn)
begin
i_ARVALID<=0;
i_RREADY<=0;
end
else
begin
if(read)//read transaction code
begin
i_ARVALID<=1;
i_RREADY<=1;
i_ARADDR<=addr;
end
else
begin
i_ARVALID<=0;
i_RREADY<=0;
i_ARADDR<=0;
end

if (write)//write transaction code
begin
i_AWVALID<=1;
i_WVALID<=1;
i_AWADDR<=addr; $display("hello");$display(i_AWADDR);
i_WDATA<=data;
if(WREADY)begin
i_BREADY<=1;i_BRESP<=1; end
else begin
i_BREADY<=0;i_BRESP<=0;end
end
else
begin
i_AWVALID<=0;
i_WVALID<=0;
i_BREADY<=0;
i_BRESP<=0;
end
end
end

write_address_master wam(ACLK, ARESETn,i_AWVALID, o_AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);
write_data_master wdm (ACLK, ARESETn,i_WVALID,o_WVALID, WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB);
write_response_master wrm(ACLK,ARESETn, BVALID, i_BREADY, o_BREADY, i_BRESP, o_BRESP);

read_address_master ram(ACLK, ARESETn, i_ARVALID, o_ARVALID, ARREADY, i_ARADDR, o_ARADDR, ARPROT);
read_data_master rdm(ACLK, ARESETn ,RVALID, i_RREADY, o_RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);

endmodule
