interface async_fifo_intfc(input reg wr_clk_i,rd_clk_i,rst_i);
	bit wr_en_i;
	bit rd_en_i;
	bit [`WIDTH-1:0]wdata_i;
	bit [`WIDTH-1:0]rdata_o;
	bit wr_error_o;
	bit rd_error_o;
	bit empty_o;
	bit full_o;

	clocking wr_drv_cb@(posedge wr_clk_i);
		default input #0 output #1;
		output wr_en_i;
		output wdata_i;
	endclocking
	
	clocking rd_drv_cb@(posedge rd_clk_i);
		default input #0 output #1;
		output rd_en_i;
		input rdata_o;
	endclocking

	clocking wr_mon_cb@(posedge wr_clk_i);
		default input #0;
		input  wr_en_i;
		input  rd_en_i;
		input  wdata_i;
		input  rdata_o;
		input  wr_error_o;
		input  rd_error_o;
		input  empty_o;
		input  full_o;
	endclocking
	clocking rd_mon_cb@(posedge rd_clk_i);
		default input #0;
		input  wr_en_i;
		input  rd_en_i;
		input  wdata_i;
		input  rdata_o;
		input  wr_error_o;
		input  rd_error_o;
		input  empty_o;
		input  full_o;
	endclocking
endinterface
