module master_ar(
		input ACLK,
		input rst,
		input write,
		input read);

wire RVALID,o_ARVALID,o_RREADY;
wire [31:0] i_RDATA, o_ARADDR, s_ARADDR, o_RDATA;
wire [1:0] i_RRESP, o_RRESP;
wire ARREADY;

master m (ACLK, rst, write, read, RVALID, i_RDATA, i_RRESP, o_ARVALID, o_ARADDR, o_RREADY, o_RRESP,o_RDATA);
slave_ar s (ACLK, rst, write, read,o_ARVALID,o_RREADY, o_ARADDR, ARREADY, RVALID,i_RRESP, s_ARADDR, i_RDATA);                                        //check arready

endmodule

module master(
		input ACLK,
		input rst,
		input write,
		input read,

		input RVALID,
		input AWREADY,
		input [31:0] i_RDATA,
		input [1:0] i_RRESP,

		output o_ARVALID,
		output [31:0] o_ARADDR,
		output o_RREADY,
		output [1:0] o_RRESP,
		output o_AWVALID
		output [31:0] o_RDATA
		);
reg aw_valid;
reg ar_valid;
reg w_valid;
reg r_ready;
reg wresp_ready;

reg [31:0] ar_addr;
reg [31:0] aw_addr;
reg [31:0] out_data;
reg [31:0] in_data;
reg [2:0] prot;
reg [1:0] in_rresp;
reg [1:0] in_wresp;

wire ar_valid_out;                         //check

always @(ACLK) begin

if (write) begin

aw_valid <= 1'b1;
aw_addr <= 32'hffffffff;

w_valid <= 1'b1;
out_data <= 32'h11111111;

wresp_ready <= 1'b1;

end

else begin
aw_valid <= 1'b0;
aw_addr <= 32'h00000000;

w_valid <= 1'b0;
out_data <= 32'h00000000;

wresp_ready <= 1'b0;
end

if(read) begin

prot <= 3'b000;

ar_valid <= 1'b1;
ar_addr <= 32'hffffffff;

r_ready <= 1'b1;

end

else begin

ar_valid <= 1'b0;
ar_addr <= 32'h00000000;

r_ready <= 1'b0;

end
end

read_address_master read_addr_m (.ACLK(ACLK), .ARESETn(rst), .i_ARVALID(ar_valid), .o_ARVALID(o_ARVALID), .ARREADY(r_ready), .i_ARADDR(ar_addr), .o_ARADDR(o_ARADDR), .ARPROT(prot));

read_data_master read_data_m (.ACLK(ACLK), .ARESETn(rst) ,.RVALID(RVALID), .i_RREADY(r_ready), .o_RREADY(o_RREADY), .i_RDATA(i_RDATA), .o_RDATA(o_RDATA), .i_RRESP(i_RRESP), .o_RRESP(o_RRESP));

//write_address_master write_addr_m (.ACLK(ACLK), .ARESETn(rst), .i_AWVALID(aw_valid), .o_AWVALID(o_AWVALID), .AWREADY(AWREADY), i_AWADDR(aw_addr), o_AWADDR, AWPROT);

endmodule 


module slave_ar (
		input ACLK,
		input rst,
		input write,
		input read,
		
		input ARVALID,
		input RREADY,
		input [31:0] i_ARADDR,

		output o_ARREADY,
		output o_RVALID,
		output o_RRESP,
		output [31:0] o_ARADDR,
		output [31:0] o_RDATA
		);
reg aw_ready;
reg ar_ready;
reg w_ready;
reg r_valid;
reg wresp_valid;

reg [31:0] ar_addr;
reg [31:0] aw_addr;
reg [31:0] out_data;
reg [31:0] in_data;
reg [2:0] prot;
reg [1:0] rresp, wresp;

wire m_ar_valid;
wire [31:0] m_ar_addr;

always @(ACLK) begin

if (read) begin             //read from slave

ar_ready <= 1'b1;

r_valid <= 1'b1;
out_data <= 32'hffffffff;

rresp <= 2'b11;

end

else begin

ar_ready <= 1'b0;

r_valid <= 1'b0;
out_data <= 32'h11111111;

rresp <= 2'b00;

end

if (write) begin     //if write to slave

aw_ready <= 1'b1;

w_ready <= 1'b1;

wresp_valid <= 1'b1;
wresp <= 2'b11;

end

else begin

aw_ready <= 1'b0;

w_ready <= 1'b0;

wresp <= 2'b00;

end
end

//read_address_master read_addr_m (ACLK, ARESETn, i_ARVALID, .o_ARVALID(m_ar_valid), ARREADY, i_ARADDR, .o_ARADDR(m_ar_addr), ARPROT);
read_address_slave s (.ACLK(ACLK), .ARESETn(rst), .i_ARREADY(ar_ready), .o_ARREADY(o_ARREADY), .ARVALID(ARVALID), .i_ARADDR(i_ARADDR), .o_ARADDR(o_ARADDR));

read_data_slave s1 (.ACLK(ACLK), .ARESETn(rst), .i_RVALID(r_valid), .o_RVALID(o_RVALID), .RREADY(RREADY), .i_RDATA(out_data), .o_RDATA(o_RDATA), .i_RRESP(rresp), .o_RRESP(o_RRESP));

endmodule












