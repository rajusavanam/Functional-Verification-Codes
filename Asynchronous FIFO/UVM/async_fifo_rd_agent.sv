class async_fifo_rd_agent extends uvm_agent;
	
	`uvm_component_utils(async_fifo_rd_agent)
	`NEW_COMP

	async_fifo_rd_sqr rd_sqr;
	async_fifo_rd_drv rd_drv;
	async_fifo_rd_mon rd_mon;
	async_fifo_rd_cov rd_cov;

	function void build_phase(uvm_phase phase);
		rd_sqr = async_fifo_rd_sqr::type_id::create("rd_sqr",this);
		rd_drv = async_fifo_rd_drv::type_id::create("rd_drv",this);
		rd_mon = async_fifo_rd_mon::type_id::create("rd_mon",this);
		rd_cov = async_fifo_rd_cov::type_id::create("rd_cov",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		rd_drv.seq_item_port.connect(rd_sqr.seq_item_export);
		//rd_mon.ap_port.connect(rd_cov.analysis_export);
		rd_drv.rd_ap_port.connect(rd_cov.analysis_export);
	endfunction
endclass
