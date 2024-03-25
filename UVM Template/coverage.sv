class coverage extends uvm_subscriber#(tx);
	`uvm_component_utils(coverage)

	covergroup cg;

	endgroup

	function new (string name,uvm_component parent);
		super.new(name,parent);
		cg = new();
	endfunction

	function void write(tx t);
		//
		cg.sample();
	endfunction
endclass
