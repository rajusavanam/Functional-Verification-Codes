`define NEW_COMP \
	function new(string name = "",uvm_component parent);\
		super.new(name,parent);\
	endfunction


`define NEW_OBJ \
	function new(string name="");\
		super.new(name);\
	endfunction

class alu_common;
	static int count = 30;
endclass
