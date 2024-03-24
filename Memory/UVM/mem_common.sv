`define NEW_COMP \
	function new(string name="", uvm_component parent);\
		super.new(name,parent);\
	endfunction
`define NEW_OBJ \
	function new(string name="");\
		super.new(name);\
	endfunction

class mem_common;
	static int total_tx_count = 20;
	static int num_matches=0;
	static int num_mis_matches=0;
endclass
