
module read_data_master(ACLK, ARESETn,RVALID,o_RREADY, i_RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);
input ACLK;
input ARESETn;
input RVALID;
input i_RREADY;
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

always @ (posedge ACLK)
begin
if(o_RREADY && RVALID)
begin
o_RDATA<=i_RDATA;
end
else
begin
o_RDATA<=0;
end
end
endmodule

module read_data_slave(ACLK, ARESETn,i_RVALID,o_RVALID, RREADY, i_RDATA, o_RDATA, i_RRESP, o_RRESP);
input ACLK;
input ARESETn;
input i_RVALID;
input RREADY;
input [31:0] i_RDATA;   
output reg o_RVALID; 
input[1:0] i_RRESP;
output reg [1:0] o_RRESP; 
output reg [31:0] o_RDATA; 

always @ (posedge ARESETn)
begin
o_RVALID<=0;
o_RDATA<=0;
end

always @ (i_RVALID)
begin
if(i_RVALID)
o_RVALID=1;
else
o_RVALID=0;
end

always @ (posedge ACLK)
begin
if(RREADY && o_RVALID)
begin
o_RDATA<=i_RDATA;
end
else
begin
o_RDATA<=0;
end
end
endmodule










