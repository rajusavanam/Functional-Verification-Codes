class sy_fifo_env;
	sy_fifo_agent agent = new();

	task run();
		agent.run();
	endtask

endclass
