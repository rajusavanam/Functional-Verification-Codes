class mem_drv extends uvm_driver#(mem_tx);
	mem_tx tx;
	virtual mem_intfc vif;
	`uvm_component_utils(mem_drv)
	`NEW_COMP
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_resource_db#(virtual mem_intfc)::read_by_name("GLOBAL","MEM_INTFC",vif,this);
	endfunction
	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
			req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(mem_tx tx);
		@(vif.drv_cb)
		vif.drv_cb.valid_i <=1;
		vif.drv_cb.wr_rd_en_i <= tx.wr_rd_en;
		vif.drv_cb.addr_i <= tx.addr;
		if(tx.wr_rd_en==1) vif.drv_cb.wdata_i <= tx.data;
		wait(vif.drv_cb.ready_o == 1);
		
		@(vif.drv_cb);
		if(tx.wr_rd_en==0) tx.data = vif.drv_cb.rdata_o;
		top.reset_inputs();
	endtask
endclass
