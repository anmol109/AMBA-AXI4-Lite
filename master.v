module master(ACLK, addr_req, data_out, valid_out, resp_in, select);

parameter addr1 = 32'h00110022;  //slave 1 address
parameter addr2 = 32'h11111111;  //slave 2 address

parameter data = 32'h01010101;

parameter valid = 1'b1;

output reg [31:0] addr_req;
output [31:0] data_out;
output valid_out;

input ACLK;
input select;
input [1:0] resp_in;

assign data_out = data;
assign valid_out = valid;

always @(ACLK) begin

if(select == 1'b0) addr_req = addr1;
else addr_req = addr2;

end

endmodule


