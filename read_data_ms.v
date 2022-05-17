module read_data_ms(ACLK, ARESETn, RVALID, RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);

input ACLK, ARESETn;
input RVALID, RREADY;
input [31:0] i_RDATA;
input [1:0] i_RRESP;

output [31:0] o_RDATA;
output [1:0] o_RRESP;

read_data_master data1 (ACLK, ARESETn ,RVALID, i_RREADY, o_RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);
read_data_slave data2 (ACLK, ARESETn, i_RVALID, o_RVALID, RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);

endmodule

module read_data_master(ACLK, ARESETn ,RVALID, i_RREADY, o_RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);

input ACLK, ARESETn;
input RVALID, i_RREADY;
input [31:0] i_RDATA;   
input [1:0] i_RRESP;

output reg o_RREADY; 
output reg [1:0] o_RRESP; 
output reg [31:0] o_RDATA; 

always @ (posedge ARESETn)
begin
o_RREADY<=0;
o_RDATA<=0;
end

always @ (i_RREADY)
begin
if(i_RREADY)
o_RREADY=1;
else
o_RREADY=0;
end

always @ (posedge ACLK) begin

if(o_RREADY && RVALID) o_RDATA<=i_RDATA;

else o_RDATA<=0;

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

always @ (posedge ARESETn)
begin
o_RVALID <= 0;
o_RDATA <= 0;
end

always @ (i_RVALID) o_RVALID <= i_RVALID;
/*begin
if(i_RVALID)
o_RVALID=1;
else
o_RVALID=0;
end*/

always @ (posedge ACLK)
begin
if(RREADY && o_RVALID)
begin
o_RDATA <= i_RDATA;
end
else
begin
o_RDATA <= 0;
end
end
endmodule









