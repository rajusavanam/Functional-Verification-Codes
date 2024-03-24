class async_fifo_wr_agent extends uvm_agent;
	
	`uvm_component_utils(async_fifo_wr_agent)
	`NEW_COMP

	async_fifo_wr_sqr wr_sqr;
	async_fifo_wr_drv wr_drv;
	async_fifo_wr_mon wr_mon;
	async_fifo_wr_cov wr_cov;

	function void build_phase(uvm_phase phase);
		wr_sqr = async_fifo_wr_sqr::type_id::create("wr_sqr",this);
		wr_drv = async_fifo_wr_drv::type_id::create("wr_drv",this);
		wr_mon = async_fifo_wr_mon::type_id::create("wr_mon",this);
		wr_cov = async_fifo_wr_cov::type_id::create("wr_cov",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		wr_drv.seq_item_port.connect(wr_sqr.seq_item_export);
		//wr_mon.ap_port.connect(wr_cov.analysis_export);
		wr_drv.wr_ap_port.connect(wr_cov.analysis_export);
	endfunction
endclass
