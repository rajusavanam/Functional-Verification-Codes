class axi_env extends uvm_env;
	
	`uvm_component_utils(axi_env);
	`NEW_COMP

	axi_agent magent;
	axi_agent sagent;
	axi_sbd sbd;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		magent = axi_agent::type_id::create("magent",this);
		sagent = axi_agent::type_id::create("sagent",this);
		sbd	= axi_sbd::type_id::create("sbd",this);

		uvm_config_db#(int)::set(this,"magent*","master_slave_f",1);
		uvm_config_db#(int)::set(this,"sagent*","master_slave_f",0);
	endfunction

	function void connect_phase(uvm_phase phase);
		magent.mon.ap_port.connect(sbd.m_imp);
		sagent.mon.ap_port.connect(sbd.s_imp);
	endfunction
endclass
