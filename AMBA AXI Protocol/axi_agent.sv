class axi_agent extends uvm_agent;
	bit master_slave_f;
	`uvm_component_utils_begin(axi_agent)
		`uvm_field_int(master_slave_f,UVM_ALL_ON)
	`uvm_component_utils_end
	`NEW_COMP

	axi_sequencer sqr;
	axi_driver drv;
	axi_monitor mon;
	axi_coverage cov;
	axi_responder rspdr;

	function void build_phase(uvm_phase phase);
		`uvm_info("AXI_AGENT","Inside Build Phase of AXI AGENT",UVM_HIGH)
		super.build_phase(phase);
		if(!uvm_config_db#(int)::get(this,"","master_slave_f",master_slave_f))begin
			`uvm_error("AXI_AGENT_BUILD_PHASE","Master_Slave_Flag Not got")
		end
		if(master_slave_f == `MASTER)begin
			sqr = axi_sequencer::type_id::create("sqr",this);
			drv = axi_driver::type_id::create("drv",this);
			cov = axi_coverage::type_id::create("cov",this);
		end
		else begin
			rspdr = axi_responder::type_id::create("rspdr",this);
		end
		mon = axi_monitor::type_id::create("mon",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		if(master_slave_f == `MASTER)begin
			drv.seq_item_port.connect(sqr.seq_item_export);
			mon.ap_port.connect(cov.analysis_export);
		end
	endfunction
endclass
