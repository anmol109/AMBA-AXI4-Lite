module read_data_ms(ACLK, ARESETn, RVALID, RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);

input ACLK, ARESETn;
input RVALID, RREADY;
input [31:0] i_RDATA;
input [1:0] i_RRESP;

output [31:0] o_RDATA;
output [1:0] o_RRESP;

wire [31:0] w_RDATA;
wire [1:0] w_RRESP;
wire o_RVALID,o_RREADY;

read_data_slave data2 (ACLK, ARESETn, RVALID, o_RVALID, o_RREADY, i_RDATA, w_RDATA, i_RRESP, w_RRESP);
read_data_master data1 (ACLK, ARESETn ,o_RVALID, RREADY, o_RREADY, w_RDATA, o_RDATA, w_RRESP, o_RRESP);

endmodule

module read_data_master(ACLK, ARESETn ,RVALID, i_RREADY, o_RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);

input ACLK, ARESETn;
input RVALID, i_RREADY;
input [31:0] i_RDATA;   
input [1:0] i_RRESP;

output reg o_RREADY; 
output reg [1:0] o_RRESP;    //RESP remaining
output reg [31:0] o_RDATA; 


always @ (posedge ACLK) begin
o_RRESP<=i_RRESP;
o_RDATA <= i_RDATA;
o_RREADY <= i_RREADY;
if(ARESETn)
begin
o_RREADY <= 0;
o_RDATA <= 0;
end
end
endmodule

module read_data_slave(ACLK, ARESETn, i_RVALID, o_RVALID, RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);
input ACLK, ARESETn;
input i_RVALID, RREADY;
input [31:0] i_RDATA;
input[1:0] i_RRESP;
   
output reg o_RVALID; 
output reg [1:0] o_RRESP; 
output reg [31:0] o_RDATA; 



/*begin
if(i_RVALID)
o_RVALID=1;
else
o_RVALID=0;
end*/

always @ (posedge ACLK)
begin
o_RVALID <= i_RVALID;
if(ARESETn)
begin
o_RVALID <= 0;
o_RDATA <= 0;
end
else if(RREADY && o_RVALID)
begin
 o_RDATA <= i_RDATA;
 o_RRESP <= i_RRESP;
 end
else begin
 o_RDATA <= 32'b0;
 o_RRESP<=2'b0;
 end

end
endmodule










