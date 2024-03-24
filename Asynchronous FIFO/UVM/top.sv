module top;
	reg wr_clk, rd_clk,rst;

	async_fifo_intfc pif(wr_clk,rd_clk,rst);

	async_fifo_gray #(.WIDTH(`WIDTH),.DEPTH(`DEPTH)) dut (.wr_clk_i(pif.wr_clk_i),
														.rd_clk_i(pif.rd_clk_i),
														.rst_i(pif.rst_i),
														.wr_en_i(pif.wr_en_i),
														.rd_en_i(pif.rd_en_i),
														.wdata_i(pif.wdata_i),
														.rdata_o(pif.rdata_o),
														.wr_error_o(pif.wr_error_o),
														.rd_error_o(pif.rd_error_o),
														.empty_o(pif.empty_o),
														.full_o(pif.full_o));

	
	always #5 wr_clk=~wr_clk;
	always #10 rd_clk=~rd_clk;

	initial begin
		//uvm_resource_db#(virtual async_fifo_intfc)::set("GLOBAL","ASYNC_FIFO_VIF",pif,null);
		uvm_config_db#(virtual async_fifo_intfc)::set(null,"*","ASYNC_FIFO_VIF",pif);
	end
	initial begin
		wr_clk=0;
		rd_clk=0;
		rst = 1;
		repeat(2)@(posedge wr_clk);
		rst=0;
	end
	initial begin
		run_test("base_test");
	end
endmodule
