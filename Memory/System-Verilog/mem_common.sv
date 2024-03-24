`define MEM_WIDTH 16
`define MEM_DEPTH 64
`define ADDR_WIDTH $clog2(`MEM_DEPTH)

class mem_common;
	static mailbox gen2bfm = new();
	static mailbox mon2cov = new();
	static mailbox mon2sbd = new();

	static virtual mem_intfc vif;

	static int count = 15;
	static int match = 0;
	static int mis_match = 0;
	static string testcase = "multiple_wr_rd";
endclass
