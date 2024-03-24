class async_fifo_env extends uvm_env;

	async_fifo_wr_agent wr_agent;
	async_fifo_rd_agent rd_agent;
	
	async_fifo_sbd sbd;

	top_sqr top_sqr_i;
	
	`uvm_component_utils(async_fifo_env)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		wr_agent = async_fifo_wr_agent::type_id::create("wr_agent",this);
		rd_agent = async_fifo_rd_agent::type_id::create("rd_agent",this);
		sbd = async_fifo_sbd::type_id::create("sbd",this);
		top_sqr_i=top_sqr::type_id::create("top_sqr_i",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		wr_agent.wr_mon.wr_ap_port.connect(sbd.wr_imp);
		rd_agent.rd_mon.rd_ap_port.connect(sbd.rd_imp);
		top_sqr_i.wr_sqr = wr_agent.wr_sqr;
		top_sqr_i.rd_sqr = rd_agent.rd_sqr;
	endfunction

endclass
