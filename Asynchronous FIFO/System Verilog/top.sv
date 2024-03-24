// Top Module of Synchronous FIFO Design
module top;

reg clk,rst;

sy_fifo_intfc pif(clk,rst); // Interface Instantiation

sy_fifo_env env;

sync_fifo_design #(.WIDTH(`WIDTH),.DEPTH(`DEPTH),.ADDRESS_WIDTH(`ADDRESS_WIDTH)) dut(.clk_i(pif.clk_i),
					.rst_i(pif.rst_i),
					.wr_en_i(pif.wr_en_i),
					.rd_en_i(pif.rd_en_i),
					.wdata_i(pif.wdata_i),
					.rdata_o(pif.rdata_o),
					.empty_o(pif.empty_o),
					.full_o(pif.full_o),
					.error_o(pif.error_o));

initial begin
	sy_fifo_common::vif = pif;
end
always begin
	#5 clk=0;
	#5 clk=1;
end
initial begin
//	#20;
	env=new();
	env.run();
end

initial begin
	#10;
	wait(sy_fifo_common::bfm_count == sy_fifo_common::tx_count);
	#100;
	$finish;
end

task reset();
	pif.wr_en_i = 0;
	pif.rd_en_i = 0;
	pif.wdata_i = 0;
endtask

initial begin
	//$value$plusargs("testcase=%s",sy_fifo_common::testcase);
	rst = 1;
	reset();
	repeat(2)@(posedge clk);
	rst = 0;
end

endmodule
