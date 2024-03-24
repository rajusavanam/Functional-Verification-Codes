class top_sqr extends uvm_sequencer;
	`uvm_component_utils(top_sqr)
	`NEW_COMP
	
	async_fifo_wr_sqr wr_sqr;
	async_fifo_rd_sqr rd_sqr;
endclass
