module top;

reg clk,rst;

always begin
	#5 clk = 0;
	#5 clk = 1;
end
initial begin
	run_test("base_test");
end

endmodule
