class alu_agent extends uvm_agent;
	alu_sqr sqr;
	alu_drv drv;
	alu_mon mon;
	alu_cov cov;

	`uvm_component_utils(alu_agent)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		sqr = alu_sqr::type_id::create("sqr",this);
		drv = alu_drv::type_id::create("drv",this);
		mon = alu_mon::type_id::create("mon",this);
		cov = alu_cov::type_id::create("cov",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		mon.ap_port.connect(cov.analysis_export);
	endfunction
endclass
