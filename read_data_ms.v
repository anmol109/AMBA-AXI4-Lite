module read_data_master(ACLK, ARESETn,RVALID,o_RREADY, i_RREADY, i_RDATA, o_RDATA, RRESP);
input ACLK;
input ARESETn;
input RVALID;
input i_RREADY;
input [31:0] i_RDATA;   
output reg o_RREADY; 
output reg RRESP; 
output reg [31:0] o_RDATA; 

always @ (posedge ARESETn)
begin
o_RREADY<=0;
RRESP<=0;
o_RDATA<=0;
end

always @ (i_RREADY)
begin
if(i_RREADY)
o_RREADY=1;
else
o_RREADY=0;
end

always @ (posedge ACLK)
begin
if(o_RREADY && RVALID)
begin
o_RDATA<=i_RDATA;
RRESP<=1;
end
else
begin
o_RDATA<=0;
RRESP<=0;
end
end
endmodule






