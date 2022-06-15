module slave2(ACLK, ready_out, resp_out, addr_in, data_in);

parameter addr = 32'h11111111;

parameter ready = 1'b1;

output reg ready_out;
output reg [1:0] resp_out;

input ACLK;
input [31:0] addr_in;
input [31:0] data_in;

always @(ACLK) begin

if(addr_in == addr) ready_out <= ready; 

end

always @(data_in) resp_out <= 2'b11;

endmodule
