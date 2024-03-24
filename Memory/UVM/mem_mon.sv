class mem_mon extends uvm_monitor;
	uvm_analysis_port#(mem_tx) ap_port;
	virtual mem_intfc vif;
	mem_tx tx;
	`uvm_component_utils(mem_mon)
	`NEW_COMP
	function void build_phase(uvm_phase phase);
		uvm_resource_db#(virtual mem_intfc)::read_by_name("GLOBAL","MEM_INTFC",vif,this);
		ap_port = new("ap_port",this);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			@(vif.mon_cb);
			if(vif.mon_cb.valid_i==1 && vif.mon_cb.ready_o==1)begin
				tx = mem_tx::type_id::create("tx");
				tx.wr_rd_en = vif.mon_cb.wr_rd_en_i;
				tx.addr = vif.mon_cb.addr_i;
				if(vif.mon_cb.wr_rd_en_i==1)tx.data = vif.mon_cb.wdata_i;
				if(vif.mon_cb.wr_rd_en_i==0)tx.data = vif.mon_cb.rdata_o;
				ap_port.write(tx);
			end
		end
	endtask
endclass
