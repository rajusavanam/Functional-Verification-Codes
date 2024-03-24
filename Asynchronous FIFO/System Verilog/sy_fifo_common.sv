class sy_fifo_common;
	static mailbox gen2bfm = new();
	static virtual sy_fifo_intfc vif;
	static string testcase="wr_rd_all";
	static int count = `DEPTH;
	static int bfm_count;
	static int tx_count;
endclass
