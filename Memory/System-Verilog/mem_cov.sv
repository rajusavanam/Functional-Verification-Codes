class mem_cov;
	mem_tx tx;

	covergroup cg;
		ADDR: coverpoint tx.addr
		{
			option.auto_bin_max=6;
		}
		WR_RD: coverpoint tx.wr_rd_en
		{
			bins WRITE = {1'b1};
			bins READ = {1'b0};
		}
		ADDR_X_WR_RD: cross ADDR,WR_RD;
	endgroup
	
	function new();
		cg=new();
	endfunction

	task run();
		$display("COVERAGE RUNNING");
		forever begin
			tx = new();
			mem_common::mon2cov.get(tx);
			cg.sample();
		end
	endtask
endclass
