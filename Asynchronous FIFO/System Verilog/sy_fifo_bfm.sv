class sy_fifo_bfm;
	sy_fifo_tx tx;
	virtual sy_fifo_intfc vif;

	function new();
		vif = top.pif;
	endfunction

	task run();
		@(negedge vif.rst_i);
		forever begin
			tx=new();
			sy_fifo_common::gen2bfm.get(tx);
			sy_fifo_common::bfm_count++;
			drive_tx(tx);
			tx.print();
		end
	endtask

	task drive_tx(sy_fifo_tx tx);
		@(vif.bfm_cb)
		vif.bfm_cb.wr_en_i <= tx.wr_en;
		vif.bfm_cb.rd_en_i <= tx.rd_en;
		if(tx.wr_en == 1) vif.bfm_cb.wdata_i <= tx.data;
		
		@(vif.bfm_cb)
		if(tx.rd_en == 1) tx.data = vif.bfm_cb.rdata_o;
		top.reset();
	endtask
endclass
