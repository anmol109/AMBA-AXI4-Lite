module write_response(ACLK,ARESETn,o_BRESP, BVALID, BREADY,i_BRESP,);
	input ACLK;
        input ARESETn;
        input [1:0] BRESP;
        input BVALID;
        output BREADY;
write_response_master addr_m(ACLK,ARESETn, BVALID, i_BREADY, o_BREADY);
write_response_slave addr_s(ACLK, ARESETn,i_BVALID, o_BVALID, BREADY);
endmodule




module write_response_master addr_m(ACLK,ARESETn, BVALID, i_BREADY, o_BREADY, i_BRESP);
	input ACLK;
	input ARESETn;
	output reg o_BREADY;
	input i_BREADY;
	input BVALID;
	
	
	always @(posedge ACLK) begin    // RESET
		if(ARESETn)
		o_BREADY <=0;
		else
		o_BREADY <=i_BREADY;
		end

      
endmodule
module write_response_slave addr_s(ACLK, ARESETn,i_BVALID, o_BVALID, BREADY,o_BRESP);
	input ACLK;
	input ARESETn;
	input i_AWVALID;
	input BREADY;
	output reg o_BVALID;
	        	
	always @(posedge ACLK) begin    // RESET
		if(ARESETn)
		o_BVALID <=0;
		else
		o_BVALID<=i_BVALID;
		if(o_BVALID && BREADY)
		o_BRESP<=i_BRESP;
		else
		o_BRESP<=2'b0;
		end

endmodule	

                    
