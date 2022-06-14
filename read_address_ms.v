module read_address_ms(ACLK, ARESETn, ARVALID, ARREADY,i_ARADDR, o_ARADDR, ARPROT);

input ACLK, ARESETn;
input ARVALID, ARREADY;
input [2:0] ARPROT;
input [31:0] i_ARADDR;
output [31:0] o_ARADDR;

wire o_ARREADY, o_ARVALID;
wire [31:0] w_ARADDR;

read_address_master addr1 (ACLK, ARESETn, ARVALID, o_ARVALID, o_ARREADY, i_ARADDR, w_ARADDR, ARPROT);
read_address_slave addr2 (ACLK, ARESETn, ARREADY, o_ARREADY, o_ARVALID, w_ARADDR, o_ARADDR);

endmodule


module read_address_master(ACLK, ARESETn, i_ARVALID, o_ARVALID, ARREADY, i_ARADDR, o_ARADDR, ARPROT);

input ACLK, ARESETn;
input i_ARVALID, ARREADY;
input [31:0] i_ARADDR;
input [2:0] ARPROT; // unfinished
output reg o_ARVALID;
output reg [31:0] o_ARADDR;


always @(posedge ACLK) begin
o_ARVALID <= i_ARVALID;

if(ARESETn) begin
o_ARADDR <= 0;
o_ARVALID <= 0;
end

if(o_ARVALID && ARREADY) 
o_ARADDR <= i_ARADDR;     //handshaking and address send
else  
o_ARADDR <= 32'b0;

end

endmodule


module read_address_slave(ACLK, ARESETn, i_ARREADY, o_ARREADY, ARVALID, i_ARADDR, o_ARADDR);

input ACLK, ARESETn;
input i_ARREADY, ARVALID;
input [31:0] i_ARADDR;

output reg [31:0] o_ARADDR;
output reg o_ARREADY;


always @(posedge ACLK) begin
o_ARREADY <= i_ARREADY;
if(ARESETn) begin
o_ARADDR <= 0;
o_ARREADY <= 0;
end

if(ARVALID && o_ARREADY) 
o_ARADDR <= i_ARADDR;
else
o_ARADDR<=0;
end

endmodule 
