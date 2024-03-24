class async_fifo_rd_mon extends uvm_monitor;
	`uvm_component_utils(async_fifo_rd_mon)
	`NEW_COMP

	rd_tx tx;
	virtual async_fifo_intfc vif;
	uvm_analysis_port#(rd_tx)rd_ap_port;

	function void build_phase(uvm_phase phase);
		uvm_config_db#(virtual async_fifo_intfc)::get(this,"","ASYNC_FIFO_VIF",vif);
		if(!uvm_config_db#(virtual async_fifo_intfc)::get(this,"","ASYNC_FIFO_VIF",vif))begin
			`uvm_error("ASYNC_FIFO_RD_MON","Interface handle not got in READ MONITOR");
		end
		rd_ap_port=new("rd_ap_port",this);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			@(vif.rd_mon_cb);
			if(vif.rd_en_i==1)begin
				tx=rd_tx::type_id::create("tx");
				tx.rd_data=vif.rd_mon_cb.rdata_o;
				rd_ap_port.write(tx);
			end
		end
	endtask
endclass
