interface mem_intfc(input bit clk_i,rst_i);
	
	bit wr_rd_en_i,valid_i;
	bit [`ADDR_WIDTH-1:0]addr_i;
	bit [`MEM_WIDTH-1:0]wdata_i,rdata_o;
	bit ready_o;

	clocking bfm_cb@(posedge clk_i);
		default input #0 output #1;

		input ready_o;
		input rdata_o;
		output wr_rd_en_i;
		output valid_i;
		output addr_i;
		output wdata_i;
	endclocking

	clocking mon_cb@(posedge clk_i);
		default input #1;
		input ready_o;
		input rdata_o;
		input wr_rd_en_i;
		input valid_i;
		input addr_i;
		input wdata_i;
	endclocking	
endinterface
