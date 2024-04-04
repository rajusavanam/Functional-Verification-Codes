class alu_env extends uvm_env;
	alu_agent agent;
	alu_sbd sbd;
	`uvm_component_utils(alu_env)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		agent = alu_agent::type_id::create("agent",this);
		sbd = alu_sbd::type_id::create("sbd",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		agent.mon.ap_port.connect(sbd.alu_imp);
	endfunction
endclass
