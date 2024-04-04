// UVM TB Development
module top;

reg clk,rst;

alu_intfc pif(clk,rst);

alu_design dut(.clk_i(pif.clk_i),
				.rst_i(pif.rst_i),
				.valid_i(pif.valid_i),
				.ready_o(pif.ready_o),
				.operand_a(pif.operand_a),
				.operand_b(pif.operand_b),
				.operation(pif.operation),
				.result(pif.result)
		);

always begin
	#5 clk = 0;
	#5 clk = 1;
end

task reset_signals();
	pif.operand_a=0;
	pif.operand_b=0;
	pif.operation=0;
endtask
initial begin
	rst = 1;
	reset_signals();
	repeat(2)@(posedge clk);
	rst = 0;
end
initial begin
	uvm_config_db#(virtual alu_intfc)::set(null,"*","ALU_INTFC",pif);
	uvm_config_db#(int)::set(null,"*","COUNT",alu_common::count);
end
initial begin
	#20;
	run_test("base_test");
end
endmodule