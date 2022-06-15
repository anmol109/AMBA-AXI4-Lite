module slave1(

parameter addr = 32'hh00110022;

parameter ready = 1'b1;

output ready_out;

input ACLK;
input [31:0] data_in;
input [31:0] addr_in;

always @(ACLK) begin
