interface mem_intfc(input logic clk_i,rst_i);
	logic wr_rd_en_i,valid_i;
	logic [`ADDR_WIDTH-1:0]addr_i;
	logic [`MEM_WIDTH-1:0]wdata_i;
	logic ready_o;
	logic [`MEM_WIDTH-1:0]rdata_o;

	clocking drv_cb@(posedge clk_i);
		default input #0 output #1;
		input ready_o;
		input rdata_o;
		output valid_i;
		output wr_rd_en_i;
		output addr_i;
		output wdata_i;
	endclocking
	clocking mon_cb@(posedge clk_i);
		default input #1;
		input ready_o;
		input rdata_o;
		input valid_i;
		input wr_rd_en_i;
		input addr_i;
		input wdata_i;
	endclocking
endinterface