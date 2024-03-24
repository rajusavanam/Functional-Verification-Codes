class sy_fifo_agent;

	sy_fifo_gen gen =new();
	sy_fifo_bfm bfm =new();

	task run();
		fork
			gen.run();
			bfm.run();
		join
	endtask
endclass
