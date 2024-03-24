class mem_mon;
	virtual mem_intfc vif;
	mem_tx tx;
	
	function new();
		vif = top.pif;
	endfunction

	task run();
		$display("MONITOR RUNNING");
		forever begin
			@(vif.mon_cb)
			if(vif.mon_cb.valid_i==1 && vif.mon_cb.ready_o==1)begin
				tx=new();
				tx.wr_rd_en = vif.mon_cb.wr_rd_en_i;
				tx.addr = vif.mon_cb.addr_i;
				if(vif.mon_cb.wr_rd_en_i==1) tx.data = vif.mon_cb.wdata_i;
				else tx.data = vif.mon_cb.rdata_o;
				mem_common::mon2cov.put(tx);
				mem_common::mon2sbd.put(tx);
			end
		end
	endtask
endclass
