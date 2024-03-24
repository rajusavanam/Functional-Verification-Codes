class async_fifo_wr_drv extends uvm_driver#(wr_tx);

	virtual async_fifo_intfc vif;
	`uvm_component_utils(async_fifo_wr_drv)
	`NEW_COMP

	uvm_analysis_port#(wr_tx)wr_ap_port;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual async_fifo_intfc)::get(this,"","ASYNC_FIFO_VIF",vif))begin
			`uvm_error("ASYNC_FIFO_WR_DRV","Interface handle not got in WRITE DRVIER");
		end
		wr_ap_port=new("wr_ap_port",this);
	endfunction

	task run_phase(uvm_phase phase);
		wait(vif.rst_i==0);
		forever begin
			seq_item_port.get_next_item(req);
			wr_ap_port.write(req);
			drive_tx(req);
			//req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(wr_tx tx);
		@(vif.wr_drv_cb);
		vif.wr_drv_cb.wr_en_i <= 1;
		vif.wr_drv_cb.wdata_i <= tx.wr_data;
		fork
			begin
				@(vif.wr_drv_cb);
				vif.wr_drv_cb.wr_en_i <= 0;
				vif.wr_drv_cb.wdata_i <= 0;
			end
		join
		//repeat(tx.wr_delay)@(posedge vif.wr_clk_i);
		repeat(tx.wr_delay)@(vif.wr_drv_cb);
	endtask
endclass
