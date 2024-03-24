class async_fifo_rd_drv extends uvm_driver#(rd_tx);

	virtual async_fifo_intfc vif;
	`uvm_component_utils(async_fifo_rd_drv)
	`NEW_COMP
	uvm_analysis_port#(rd_tx)rd_ap_port;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual async_fifo_intfc)::get(this,"","ASYNC_FIFO_VIF",vif))begin
			`uvm_error("ASYNC_FIFO_RD_DRV","Interface handle not got in READ DRVIER");
		end
		rd_ap_port=new("rd_ap_port",this);
	endfunction

	task run_phase(uvm_phase phase);
		wait(vif.rst_i==0);
		forever begin
			seq_item_port.get_next_item(req);
			rd_ap_port.write(req);
			drive_tx(req);
			//req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(rd_tx tx);
		@(vif.rd_drv_cb);
		vif.rd_drv_cb.rd_en_i <= 1;
		fork 
			begin
				@(vif.rd_drv_cb);
				tx.rd_data = vif.rd_drv_cb.rdata_o;
				vif.rd_drv_cb.rd_en_i <= 0;
			end
		join
		//repeat(tx.rd_delay)@(posedge vif.rd_clk_i);			
		repeat(tx.rd_delay)@(vif.rd_drv_cb);			
	endtask
endclass
