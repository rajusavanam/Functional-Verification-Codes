class axi_monitor extends uvm_monitor;
	`uvm_component_utils(axi_monitor)
	`NEW_COMP
	
	axi_tx tx,wrtxA[16],rdtxA[16];
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
				wrtxA[vif.mon_cb.awid] = axi_tx::type_id::create("wrtxA[vif.mon_cb.awid]");
				wrtxA[vif.mon_cb.awid].wr_rd = 1;
				wrtxA[vif.mon_cb.awid].id		= vif.mon_cb.awid;
				wrtxA[vif.mon_cb.awid].addr		= vif.mon_cb.awaddr;
				wrtxA[vif.mon_cb.awid].len		= vif.mon_cb.awlen;
				wrtxA[vif.mon_cb.awid].size		= vif.mon_cb.awsize;
				wrtxA[vif.mon_cb.awid].prot		= vif.mon_cb.awprot;
				wrtxA[vif.mon_cb.awid].cache	= vif.mon_cb.awcache;
				wrtxA[vif.mon_cb.awid].burst	= burst_t'(vif.mon_cb.awburst);
				wrtxA[vif.mon_cb.awid].lock		= lock_t'(vif.mon_cb.awlock);
			end
			// Write Data Channel
			if(vif.mon_cb.wvalid && vif.mon_cb.wready)begin
				wrtxA[vif.mon_cb.wid] = axi_tx::type_id::create("wrtxA[vif.mon_cb.wid]");
				wrtxA[vif.mon_cb.wid].data.push_back(vif.mon_cb.wdata);
			end
			// Write Response Channel
			if(vif.mon_cb.bvalid && vif.mon_cb.bready)begin
				wrtxA[vif.mon_cb.bid].resp = resp_t'(vif.mon_cb.bresp);
				ap_port.write(wrtxA[vif.mon_cb.bid]);
				wrtxA[vif.mon_cb.bid].print();
			end
			// Read Address Channel
			if(vif.mon_cb.arvalid && vif.mon_cb.arready)begin
				rdtxA[vif.mon_cb.arid] = axi_tx::type_id::create("rdtxA[vif.mon_cb.arid]");
				rdtxA[vif.mon_cb.arid].wr_rd = 0;
				rdtxA[vif.mon_cb.arid].id		=vif.mon_cb.arid;
				rdtxA[vif.mon_cb.arid].addr		=vif.mon_cb.araddr;
				rdtxA[vif.mon_cb.arid].len		=vif.mon_cb.arlen;
				rdtxA[vif.mon_cb.arid].size		=vif.mon_cb.arsize;
				rdtxA[vif.mon_cb.arid].prot		=vif.mon_cb.arprot;
				rdtxA[vif.mon_cb.arid].cache	=vif.mon_cb.arcache;
				rdtxA[vif.mon_cb.arid].burst	=burst_t'(vif.mon_cb.arburst);
				rdtxA[vif.mon_cb.arid].lock		=lock_t'(vif.mon_cb.arlock);
			end
			// Read Data Channel
			if(vif.mon_cb.rvalid && vif.mon_cb.rready)begin
				rdtxA[vif.mon_cb.rid].resp	= resp_t'(vif.mon_cb.rresp);
				rdtxA[vif.mon_cb.rid].data.push_back(vif.mon_cb.rdata);
				if(vif.mon_cb.rlast)begin
					ap_port.write(rdtxA[vif.mon_cb.rid]);
					rdtxA[vif.mon_cb.rid].print();
				end
			end
		end
	endtask

endclass
