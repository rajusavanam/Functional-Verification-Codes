module top;

reg clk,rst;

mem_intfc pif(clk,rst);

mem_design dut(.clk_i(pif.clk_i),
			.rst_i(pif.rst_i),
			.valid_i(pif.valid_i),
			.wr_rd_en_i(pif.wr_rd_en_i),
			.addr_i(pif.addr_i),
			.wdata_i(pif.wdata_i),
			.ready_o(pif.ready_o),
			.rdata_o(pif.rdata_o));

mem_assert dut_assert(.clk_i(pif.clk_i),
			.rst_i(pif.rst_i),
			.valid_i(pif.valid_i),
			.wr_rd_en_i(pif.wr_rd_en_i),
			.addr_i(pif.addr_i),
			.wdata_i(pif.wdata_i),
			.ready_o(pif.ready_o),
			.rdata_o(pif.rdata_o));

mem_env env;

always begin
	#5 clk =0;
	#5 clk =1;
end

task reset_inputs();
	pif.valid_i=0;
	pif.wr_rd_en_i=0;
	pif.addr_i=0;
	pif.wdata_i=0;
endtask

initial begin
	rst =1;
	reset_inputs();
	repeat(2)@(posedge clk);
	rst =0;
end

initial begin
	uvm_resource_db#(virtual mem_intfc)::set("GLOBAL","MEM_INTFC",pif,null);
	uvm_resource_db#(int)::set("GLOBAL","COUNT",mem_common::total_tx_count,null);
end

initial begin
	run_test("mem_base_test");
end
endmodule
