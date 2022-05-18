module write_response_ms(ACLK,ARESETn,BREADY, BVALID, i_BRESP, o_BRESP);
input ACLK, ARESETn;
input BVALID, BREADY;
input [1:0] i_BRESP;
output [1:0] o_BRESP;

wire o_BVALID, o_BREADY;
wire [1:0] w_BRESP;

write_response_slave resp_s(ACLK, ARESETn, BVALID, o_BVALID, o_BREADY, i_BRESP, w_BRESP);
write_response_master resp_m(ACLK,ARESETn, o_BVALID, BREADY, o_BREADY, w_BRESP, o_BRESP);

endmodule




module write_response_master(ACLK,ARESETn, BVALID, i_BREADY, o_BREADY, i_BRESP, o_BRESP);
input ACLK, ARESETn;
input i_BREADY, BVALID;
input [1:0] i_BRESP;

output reg [1:0] o_BRESP;
output reg o_BREADY;
	
always @(negedge ARESETn) begin   //RESET
o_BREADY <= 0;	
o_BRESP <= 0;
end

always @(i_BREADY) o_BREADY <= i_BREADY;    

always @(posedge ACLK) begin

if(o_BREADY && BVALID) o_BRESP <= i_BRESP;
else o_BRESP <= 0;

end

endmodule




module write_response_slave(ACLK, ARESETn,i_BVALID, o_BVALID, BREADY, i_BRESP, o_BRESP);
input ACLK, ARESETn;
input i_BVALID, BREADY;
input [1:0] i_BRESP;
	
output reg o_BVALID;
output reg [1:0] o_BRESP;
	        	
always @(negedge ARESETn) begin    // RESET
o_BVALID <=0;
o_BRESP <= 0;
end
	
always @(i_BVALID) o_BVALID <= i_BVALID;

always @(posedge ACLK) begin

if(BREADY && o_BVALID) o_BRESP <= i_BRESP;
else o_BRESP <= 0;

end

endmodule	

                    
