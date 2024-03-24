class mem_bfm;
	mem_tx tx;
	virtual mem_intfc vif;

	function new();
		vif = top.pif;
	endfunction

	task run();
		@(negedge vif.rst_i);
		$display("BFM RUNNING");
		forever begin
			tx = new();
			mem_common::gen2bfm.get(tx);
			drive_tx(tx);
			tx.print("BFM");
		end
	endtask

	task drive_tx(mem_tx tx);
		@(vif.bfm_cb)
		vif.bfm_cb.valid_i <=1;
		vif.bfm_cb.wr_rd_en_i <= tx.wr_rd_en;
		vif.bfm_cb.addr_i <= tx.addr;
		if(tx.wr_rd_en==1) vif.bfm_cb.wdata_i <= tx.data;

		wait(vif.bfm_cb.ready_o==1);
		@(vif.bfm_cb)
		if(tx.wr_rd_en==0) tx.data = vif.bfm_cb.rdata_o;

		top.reset_inputs();
	endtask
endclass
