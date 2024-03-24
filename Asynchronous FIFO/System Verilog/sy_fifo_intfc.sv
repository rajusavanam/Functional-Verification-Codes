`define DEPTH 16
`define WIDTH 4
`define ADDRESS_WIDTH $clog2(`DEPTH)

interface sy_fifo_intfc(input bit clk_i,rst_i);;
	
	bit wr_en_i,rd_en_i;
	bit [`WIDTH-1:0]wdata_i;
	bit empty_o,full_o,error_o;
	bit [`WIDTH-1:0]rdata_o;

	clocking bfm_cb@(posedge clk_i);
		default input #0 output #1;
		input empty_o;
		input full_o;
		input error_o;
		input rdata_o;

		output wr_en_i;
		output rd_en_i;
		output wdata_i;
	endclocking

endinterface

