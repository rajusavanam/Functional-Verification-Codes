class sbd extends uvm_scoreboard;
	uvm_analysis_imp#(tx,sbd)imp_port;
	
	`uvm_component_utils(sbd);
	`NEW_COMP

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		imp_port = new("imp_port",this);
	endfunction

	function void write(tx t);
		//
	endfunction
endclass
