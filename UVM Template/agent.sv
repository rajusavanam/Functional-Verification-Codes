class agent extends uvm_agent;
	`uvm_component_utils(agent);
	`NEW_COMP

	driver drv;
	sequencer sqr;
	monitor mon;
	coverage cov;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		drv = driver::type_id::create("drv",this);
		sqr = sequencer::type_id::create("sqr",this);
		mon = monitor::type_id::create("mon",this);
		cov = coverage::type_id::create("cov",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		mon.ap_port.connect(cov.analysis_export);
	endfunction
	
endclass
