class axi_monitor extends uvm_monitor;
	`uvm_component_utils(axi_monitor)
	`NEW_COMP
	
	axi_tx tx;
	uvm_analysis_port#(axi_tx)ap_port;
	virtual axi_intf vif;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual axi_intf)::get(this,"","vif",vif))begin
			`uvm_error("AXI_MONITOR","AXI Intf Handle not got inside AXI MONITOR BUILD PHASE")
		end
		ap_port = new("ap_port",this);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			//@(posedge vif.aclk);
			@(vif.mon_cb);
			// Write Address Channel
			if(vif.mon_cb.awvalid && vif.mon_cb.awready)begin
				tx = axi_tx::type_id::create("tx");
				tx.wr_rd = 1;
				tx.id		= vif.mon_cb.awid;
				tx.addr		= vif.mon_cb.awaddr;
				tx.len		= vif.mon_cb.awlen;
				tx.size		= vif.mon_cb.awsize;
				tx.prot		= vif.mon_cb.awprot;
				tx.cache	= vif.mon_cb.awcache;
				tx.burst	= burst_t'(vif.mon_cb.awburst);
				tx.lock		= lock_t'(vif.mon_cb.awlock);
			end
			// Write Data Channel
			if(vif.mon_cb.wvalid && vif.mon_cb.wready)begin
				tx.data.push_back(vif.mon_cb.wdata);
			end
			// Write Response Channel
			if(vif.mon_cb.bvalid && vif.mon_cb.bready)begin
				tx.resp = resp_t'(vif.mon_cb.bresp);
				ap_port.write(tx);
			end
			// Read Address Channel
			if(vif.mon_cb.awvalid && vif.mon_cb.awready)begin
				tx = axi_tx::type_id::create("tx");
				tx.wr_rd = 0;
				tx.id		=vif.mon_cb.arid;
				tx.addr		=vif.mon_cb.araddr;
				tx.len		=vif.mon_cb.arlen;
				tx.size		=vif.mon_cb.arsize;
				tx.prot		=vif.mon_cb.arprot;
				tx.cache	=vif.mon_cb.arcache;
				tx.burst	=burst_t'(vif.mon_cb.arburst);
				tx.lock		=lock_t'(vif.mon_cb.arlock);
			end
			// Read Data Channel
			if(vif.mon_cb.rvalid && vif.mon_cb.rready)begin
				tx.resp	= resp_t'(vif.mon_cb.rresp);
				tx.data.push_back(vif.mon_cb.rdata);
				if(vif.mon_cb.rlast)begin
					ap_port.write(tx);
					tx.print();
				end
			end
		end
	endtask

endclass
