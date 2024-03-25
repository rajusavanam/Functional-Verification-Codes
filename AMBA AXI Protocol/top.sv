module top;
	reg clk,rst;

	axi_intf pif(clk,rst);

	always begin
		#5 clk = ~clk;
	end

	initial begin
		uvm_config_db#(virtual axi_intf)::set(null,"*","vif",pif);
	end

	initial begin
		clk = 0;
		rst = 1;
		reset();
		repeat(2)@(posedge clk);
		rst = 0;
	end

	task reset();
		// Write Address Channel Signals
		pif.awid	=0;
		pif.awaddr	=0;
		pif.awlen	=0;
		pif.awsize	=0;
		pif.awburst	=0;
		pif.awlock	=0;
		pif.awcache	=0;
		pif.awprot	=0;
		pif.awvalid	=0;

		// Write Data Channel Signals
		pif.wid		=0;
		pif.wdata	=0;
		pif.wstrb	=0;
		pif.wlast	=0;
		pif.wvalid	=0;

		// Write Response Channel Signals
		pif.bready	=0;

		// Read Address Channel Signals
		pif.arid	=0;
		pif.araddr	=0;
		pif.arlen	=0;
		pif.arsize	=0;
		pif.arburst	=0;
		pif.arlock	=0;
		pif.arcache	=0;
		pif.arprot	=0;
		pif.arvalid	=0;

		// Read Data/Response Channel Signals
		pif.rready	=0;

	endtask
	initial begin
		run_test("base_test");
	end
endmodule
