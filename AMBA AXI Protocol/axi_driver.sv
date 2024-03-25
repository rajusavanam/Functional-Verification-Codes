class axi_driver extends uvm_driver#(axi_tx);
	`uvm_component_utils(axi_driver)
	`NEW_COMP

	virtual axi_intf vif;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual axi_intf)::get(this,"","vif",vif))begin
			`uvm_error("AXI_DRIVER","AXI Intf Handle not got inside AXI DRIVER BUILD PHASE")
		end
	endfunction

	task run_phase(uvm_phase phase);
		@(negedge vif.arst);
		wait(vif.arst == 0);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
			req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(axi_tx tx);
		if(tx.wr_rd)begin
			write_addr(tx);
			write_data(tx);
			write_resp(tx);
		end
		else begin
			read_addr(tx);
			read_data(tx);
		end
	endtask
	
	// Write Address Channel
	task write_addr(axi_tx tx);
		@(posedge vif.aclk);
		//@(vif.driver_cb);
		vif.awid	=tx.id;
		vif.awaddr	=tx.addr;
		vif.awlen	=tx.len;
		vif.awsize	=tx.size;
		vif.awburst	=tx.burst;
		vif.awlock	=tx.lock;
		vif.awcache	=tx.cache;
		vif.awprot	=tx.prot;
	 	
		vif.awvalid=1;
		wait(vif.awready);
		@(posedge vif.aclk);
		//@(vif.driver_cb);
	 	vif.awvalid=0;

		vif.awid	=0;
		vif.awaddr	=0;
		vif.awlen	=0;
		vif.awsize	=0;
		vif.awburst	=0;
		vif.awlock	=0;
		vif.awcache	=0;
		vif.awprot	=0;

	endtask

	// Write Data Channel
	task write_data(axi_tx tx);
		for(int i=0; i<=tx.len;i++)begin
			@(posedge vif.aclk);
			//@(vif.driver_cb);
			vif.wid		= tx.id;
			vif.wdata	= tx.data[i];
			vif.wstrb 	= 4'b1111;
			if(i==tx.len)begin
				vif.wlast 	= 1;
			end
			else vif.wlast = 0;
		
			vif.wvalid = 1;
			wait(vif.wready);
		end
		@(posedge vif.aclk);
		//@(vif.driver_cb);
		vif.wvalid 	= 0;
		vif.wid		= 0;
		vif.wdata	= 0;
		vif.wstrb 	= 0;
		vif.wlast 	= 0;
	endtask

	// Write Response Channel
	task write_resp(axi_tx tx);
		//wait(vif.bvalid == 1);
		//vif.bready = 1;
		while(vif.bvalid==0)begin;
			@(posedge vif.aclk);
		end
		vif.bready=1;
		@(posedge vif.aclk);
		vif.bready = 0;
	endtask

	// Read Address Channel
	task read_addr(axi_tx tx);
		@(posedge vif.aclk);
		//@(vif.driver_cb);
		vif.arid	=tx.id;
		vif.araddr	=tx.addr;
		vif.arlen	=tx.len;
		vif.arsize	=tx.size;
		vif.arburst	=tx.burst;
		vif.arlock	=tx.lock;
		vif.arcache	=tx.cache;
		vif.arprot	=tx.prot;
	 	
		vif.arvalid=1;
		wait(vif.arready);
		@(posedge vif.aclk);
		//@(vif.driver_cb);
	 	vif.arvalid=0;

		vif.arid	=0;
		vif.araddr	=0;
		vif.arlen	=0;
		vif.arsize	=0;
		vif.arburst	=0;
		vif.arlock	=0;
		vif.arcache	=0;
		vif.arprot	=0;

	endtask

	// Read Data/Response Channel
	task read_data(axi_tx tx);
		for(int i=0; i<=tx.len;i++)begin
			while(vif.rvalid==0)begin
				//@(posedge vif.aclk);
				@(vif.driver_cb);
			end
			vif.rready = 1;
			tx.data[i] = vif.rdata;
			//@(posedge vif.aclk);
			@(vif.driver_cb);
			vif.rready = 0;
		end
	endtask
endclass
