module master_ar(
		input ACLK,
		input rst,
		input write,
		input read,
		//input[3:0] fpga_ip;
		output [31:0] o_RDATA,
		output reg [6:0]SSD1,
		output reg [6:0]SSD2,
		output reg [6:0]SSD3,
		output reg [6:0]SSD4,
		output reg [6:0]SSD5,
		output reg [6:0]SSD6);

wire RVALID,o_ARVALID,o_RREADY;
wire [31:0] i_RDATA, o_ARADDR, s_ARADDR;

wire [1:0] i_RRESP, o_RRESP;
wire ARREADY;
always @(posedge ACLK)
begin

/*case (fpga_ip)
4'b1111: DATA = 32'hffffffff;
4'b1110: DATA = 32'hffffff00;
4'b1101: DATA = 32'hffff00ff;
4'b1100: DATA = 32'hffff0000;
4'b1011: DATA = 32'hff00ffff;
4'b1010: DATA = 32'hff00ff00;
4'b1001: DATA = 32'hff0000ff;
4'b1000: DATA = 32'hff000000;
4'b0111: DATA = 32'h00ffffff;
4'b0110: DATA = 32'h00ffff00;
4'b0101: DATA = 32'h00fff00f;
4'b0100: DATA = 32'h00ff0000;
4'b0011: DATA = 32'h0000ffff;
4'b0010: DATA = 32'h0000ff00;
4'b0001: DATA = 32'h000000ff;
4'b0000: DATA = 32'hff000000;
default: DATA=0;
endcase*/
case(o_RDATA[3:0])
4'b0000 : SSD1=7'b1000000;
4'b0001 : SSD1=7'b1111001;
4'b0010 : SSD1=7'b0100100;
4'b0011 : SSD1=7'b0110000;
4'b0100 : SSD1=7'b0011001;
4'b0101 : SSD1=7'b0010010;
4'b0110 : SSD1=7'b0000010;
4'b0111 : SSD1=7'b1111000;
4'b1000 : SSD1=7'b0000000;
4'b1001 : SSD1=7'b0010000;
4'b1010 : SSD1=7'b0001000;
4'b1011 : SSD1=7'b0000011;
4'b1100 : SSD1=7'b1000110;
4'b1101 : SSD1=7'b0100001;
4'b1110 : SSD1=7'b0000100;
4'b1111 : SSD1=7'b0001110;
endcase
case(o_RDATA[7:4])
4'b0000 : SSD2=7'b1000000;
4'b0001 : SSD2=7'b1111001;
4'b0010 : SSD2=7'b0100100;
4'b0011 : SSD2=7'b0110000;
4'b0100 : SSD2=7'b0011001;
4'b0101 : SSD2=7'b0010010;
4'b0110 : SSD2=7'b0000010;
4'b0111 : SSD2=7'b1111000;
4'b1000 : SSD2=7'b0000000;
4'b1001 : SSD2=7'b0010000;
4'b1010 : SSD2=7'b0001000;
4'b1011 : SSD2=7'b0000011;
4'b1100 : SSD2=7'b1000110;
4'b1101 : SSD2=7'b0100001;
4'b1110 : SSD2=7'b0000100;
4'b1111 : SSD2=7'b0001110;
endcase
case(o_RDATA[11:8])
4'b0000 : SSD3=7'b1000000;
4'b0001 : SSD3=7'b1111001;
4'b0010 : SSD3=7'b0100100;
4'b0011 : SSD3=7'b0110000;
4'b0100 : SSD3=7'b0011001;
4'b0101 : SSD3=7'b0010010;
4'b0110 : SSD3=7'b0000010;
4'b0111 : SSD3=7'b1111000;
4'b1000 : SSD3=7'b0000000;
4'b1001 : SSD3=7'b0010000;
4'b1010 : SSD3=7'b0001000;
4'b1011 : SSD3=7'b0000011;
4'b1100 : SSD3=7'b1000110;
4'b1101 : SSD3=7'b0100001;
4'b1110 : SSD3=7'b0000100;
4'b1111 : SSD3=7'b0001110;
endcase
case(o_RDATA[15:12])
4'b0000 : SSD4=7'b1000000;
4'b0001 : SSD4=7'b1111001;
4'b0010 : SSD4=7'b0100100;
4'b0011 : SSD4=7'b0110000;
4'b0100 : SSD4=7'b0011001;
4'b0101 : SSD4=7'b0010010;
4'b0110 : SSD4=7'b0000010;
4'b0111 : SSD4=7'b1111000;
4'b1000 : SSD4=7'b0000000;
4'b1001 : SSD4=7'b0010000;
4'b1010 : SSD4=7'b0001000;
4'b1011 : SSD4=7'b0000011;
4'b1100 : SSD4=7'b1000110;
4'b1101 : SSD4=7'b0100001;
4'b1110 : SSD4=7'b0000100;
4'b1111 : SSD4=7'b0001110;
endcase
case(o_RDATA[19:16])
4'b0000 : SSD5=7'b1000000;
4'b0001 : SSD5=7'b1111001;
4'b0010 : SSD5=7'b0100100;
4'b0011 : SSD5=7'b0110000;
4'b0100 : SSD5=7'b0011001;
4'b0101 : SSD5=7'b0010010;
4'b0110 : SSD5=7'b0000010;
4'b0111 : SSD5=7'b1111000;
4'b1000 : SSD5=7'b0000000;
4'b1001 : SSD5=7'b0010000;
4'b1010 : SSD5=7'b0001000;
4'b1011 : SSD5=7'b0000011;
4'b1100 : SSD5=7'b1000110;
4'b1101 : SSD5=7'b0100001;
4'b1110 : SSD5=7'b0000100;
4'b1111 : SSD5=7'b0001110;
endcase
case(o_RDATA[23:20])
4'b0000 : SSD6=7'b1000000;
4'b0001 : SSD6=7'b1111001;
4'b0010 : SSD6=7'b0100100;
4'b0011 : SSD6=7'b0110000;
4'b0100 : SSD6=7'b0011001;
4'b0101 : SSD6=7'b0010010;
4'b0110 : SSD6=7'b0000010;
4'b0111 : SSD6=7'b1111000;
4'b1000 : SSD6=7'b0000000;
4'b1001 : SSD6=7'b0010000;
4'b1010 : SSD6=7'b0001000;
4'b1011 : SSD6=7'b0000011;
4'b1100 : SSD6=7'b1000110;
4'b1101 : SSD6=7'b0100001;
4'b1110 : SSD6=7'b0000100;
4'b1111 : SSD6=7'b0001110;
endcase
end
master m (ACLK, rst, write, read, RVALID, i_RDATA, i_RRESP, o_ARVALID, o_ARADDR, o_RREADY, o_RRESP,o_RDATA);
slave_ar s (ACLK, rst, write, read,o_ARVALID,o_RREADY, o_ARADDR, ARREADY, RVALID,i_RRESP, s_ARADDR, i_RDATA);                                        //check arready

endmodule

module master(
		input ACLK,
		input rst,
		input write,
		input read,

		input RVALID,
		//input AWREADY,
		input [31:0] i_RDATA,
		input [1:0] i_RRESP,

		output o_ARVALID,
		output [31:0] o_ARADDR,
		output o_RREADY,
		output [1:0] o_RRESP,
		//output o_AWVALID,
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












