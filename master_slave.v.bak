module master_slave(input ACLK, 
		    input ARESETn,
		    input select);
		    
master m (ACLK, addr_req, data_out, valid_out, o_BRESP, select);

AXI_lite p (ACLK,ARESETn,BREADY, BVALID, resp_out, o_BRESP
	    ,WVALID, WREADY, data_out, o_WDATA, i_WSTRB, o_WSTRB
	    ,valid_out, ready_out, addr_req, o_AWADDR, AWPROT, ARVALID, ARREADY, ARPROT
	    ,i_ARADDR, o_ARADDR, RVALID, RREADY, i_RDATA, i_RRESP,o_RDATA, o_RRESP);

slave1 s1 (ACLK, ready_out, resp_out, o_AWADDR, o_WDATA);
slave2 s2 (ACLK, ready_out, resp_out, o_AWADDR, o_WDATA);

endmodule

