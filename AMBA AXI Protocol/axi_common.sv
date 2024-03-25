`define NEW_COMP \
	function new(string name, uvm_component parent);\
		super.new(name,parent);\
	endfunction

`define NEW_OBJ \
	function new(string name="");\
		super.new(name);\
	endfunction

`define MASTER 1
`define SLAVE 0

typedef enum bit[1:0]{FIXED=2'b00,INCR,WRAP,RESERVED_BURST} burst_t;

typedef enum bit[1:0]{NORMAL=2'b00,EXCLUSIVE,LOCKED,RESERVED_LOCK} lock_t;

typedef enum bit[1:0]{OKAY=2'b00,EXOKAY,SLVERR,DECERR} resp_t;


class axi_common;
	static int count = 50;
	static int num_matches;
	static int num_mismatches;
	static int tx_count;
endclass
