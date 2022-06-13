module top_ms(ACLK,ARESETn,BREADY, BVALID, i_BRESP, o_BRESP
,WVALID, WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB
 ,AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);
//Write Transaction
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

	reg[2:0] PS_r, NS_r, PS_w, NS_r;
	//idle
	parameter idle_w=3'b000, idle_r=3'b001, w_addr=3'b010, w_data=3'b011, w_resp=3'b100, r_addr=3'b101 , r_data=3'b110;
	

	always@(posedge ARESETn or posedge ACLK)
	begin
	if(ARESETn) begin
	PS_r<=idle_r;
	PS_w<=idle_w;
	end
	else 
	begin
	PS_w<=NS_w;
	PS_r<=NS_r;
	end

	always@(posedge ACLK)
	begin
		case(PS_w)
		idle_w:begin
			if(AWVALID)
			NS_w<=w_addr;
			end
		w_addr:begin
			write_address_ms addr_w(ACLK, ARESETn, AWVALID, AWREADY, i_AWADDR, o_AWADDR, AWPROT);
			if(WVALID)begin
			NS_w<=w_data;
			end
			end
		w_data:begin
			write_data_ms data_w(ACLK, ARESETn,WVALID, WREADY, i_WDATA, o_WDATA, i_WSTRB, o_WSTRB);
			if(BVALID) begin
			NS_w<=w_resp;
			end
			end
		w_resp:begin
			write_response_ms resp_w(ACLK,ARESETn,BREADY, BVALID, i_BRESP, o_BRESP);
			if(o_BRESP==2'b00)
			NS_w<=idle_w;
			else
			NS_w<=w_addr;
			end
		endcase
	end
	always@(posedge ACLK)
	begin
		case(PS_r)
		idle_r:begin
			if(ARVALID)
			PS_r<=r_addr;
			end
		r_addr:begin
			read_address_ms addr_r(ACLK, ARESETn, ARVALID, ARREADY,i_ARADDR, o_ARADDR, ARPROT);
			if(