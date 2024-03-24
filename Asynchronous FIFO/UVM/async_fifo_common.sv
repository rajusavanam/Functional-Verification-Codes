`define WIDTH 16
`define DEPTH 16

`define WR_MAX_DELAY 9
`define RD_MAX_DELAY 12

`define NEW_COMP\
	function new(string name="",uvm_component parent);\
		super.new(name,parent);\
	endfunction

`define NEW_OBJ\
	function new(string name="");\
		super.new(name);\
	endfunction

class async_fifo_common;
	static int num_matches=0;
	static int num_mis_matches=0;
endclass
