class async_fifo_wr_mon extends uvm_monitor;
	`uvm_component_utils(async_fifo_wr_mon)
	`NEW_COMP

	wr_tx tx;
	virtual async_fifo_intfc vif;
	uvm_analysis_port#(wr_tx)wr_ap_port;

	function void build_phase(uvm_phase phase);
		uvm_config_db#(virtual async_fifo_intfc)::get(this,"","ASYNC_FIFO_VIF",vif);
		if(!uvm_config_db#(virtual async_fifo_intfc)::get(this,"","ASYNC_FIFO_VIF",vif))begin
			`uvm_error("ASYNC_FIFO_WR_MON","Interface handle not got in WRITE MONITOR");
		end
		wr_ap_port=new("wr_ap_port",this);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			@(vif.wr_mon_cb);
			if(vif.wr_en_i==1)begin
				tx=wr_tx::type_id::create("tx");
				tx.wr_data=vif.wr_mon_cb.wdata_i;
				wr_ap_port.write(tx);
			end
		end
	endtask
endclass
