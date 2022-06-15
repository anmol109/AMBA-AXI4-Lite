module AXI_lite(ACLK,ARESETn,BREADY, BVALID, i_BRESP, o_BRESP
,WVALID, WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB
 ,AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT, ARVALID, ARREADY, ARPROT,
 i_ARADDR, o_ARADDR, RVALID, RREADY, i_RDATA, i_RRESP,o_RDATA, o_RRESP);

input ACLK;
	input ARESETn;
	input AWREADY, AWVALID;
	input [31:0] i_AWADDR;
	input [2:0] AWPROT;
	output [31:0]o_AWADDR;
	wire o_AREADY, o_AVALID;
	wire [31:0] w_AWADDR;
	input WVALID, WREADY;
	input [31:0] i_WDATA;
	input [3:0] i_WSTRB;  
	output [3:0] o_WSTRB;
	output [31:0] o_WDATA;
	wire o_WVALID, o_WREADY; 
	wire [3:0] w_WSTRB;
	wire [31:0] w_WDATA;
	input BVALID, BREADY;
	input [1:0] i_BRESP;
	output [1:0] o_BRESP;
	wire o_BVALID, o_BREADY;
	wire [1:0] w_BRESP;

	input ARVALID;
	input ARREADY;
	input [2:0] ARPROT;
	input [31:0] i_ARADDR;
	output [31:0] o_ARADDR;
	input RVALID, RREADY;
	input [31:0] i_RDATA;
	input [1:0] i_RRESP;
	output [31:0] o_RDATA;
	output [1:0] o_RRESP;


	write_address_ms wa(ACLK, ARESETn, AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);
 	write_data_ms wd(ACLK, ARESETn,WVALID, WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB);
	write_response_ms wr(ACLK,ARESETn,BRESP, BVALID, BREADY,);
	read_address_ms ra(ACLK, ARESETn, ARVALID, ARREADY,i_ARADDR, o_ARADDR, ARPROT);
	read_data_ms rd(ACLK, ARESETn, RVALID, RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);

endmodule