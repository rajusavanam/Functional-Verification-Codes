class env extends uvm_env;
	`uvm_component_utils(env)
	`NEW_COMP

	agent agent_i;
	sbd sbd_i;

	function void build_phase(uvm_phase phase);
		agent_i = agent::type_id::create("agent_i",this);
		sbd_i = sbd::type_id::create("sbd_i",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		agent_i.mon.ap_port.connect(sbd_i.imp_port);
	endfunction
endclass
