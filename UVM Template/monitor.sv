class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)
	`NEW_COMP

	uvm_analysis_port#(tx)ap_port;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port",this);
	endfunction

	task run_phase(uvm_phase phase);
		//
	endtask
endclass
