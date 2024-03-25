class axi_responder extends uvm_driver#(axi_tx);
	`uvm_component_utils(axi_responder)
	`NEW_COMP
	
	// Write Address Channel Signals To Capture signals from driver
	logic [3:0] awid_t;
	logic [31:0] awaddr_t;
	logic [3:0] awlen_t;
	logic [2:0] awsize_t;
	logic [1:0] awburst_t;
	logic [1:0] awlock_t;
	logic [3:0] awcache_t;
	logic [2:0] awprot_t;
	
	// Write Data Channel Signals to Capture signals from driver
	logic [3:0] wid_t;
	logic [31:0]mem[int];
	logic [3:0] wstrb_t;

	// Write Response Channel Signals
	

	// Read Address Channel Signals To Capture signals from driver
	logic [3:0] arid_t;
	logic [31:0] araddr_t;
	logic [3:0] arlen_t;
	logic [2:0] arsize_t;
	logic [1:0] arburst_t;
	logic [1:0] arlock_t;
	logic [3:0] arcache_t;
	logic [2:0] arprot_t;

	
	int lower_wrap_boundary,upper_wrap_boundary;
	virtual axi_intf vif;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual axi_intf)::get(this,"","vif",vif))begin
			`uvm_error("AXI_RESPONDER","AXI Intf Handle not got inside AXI RESPONDER BUILD PHASE")
		end
	endfunction

	task run_phase(uvm_phase phase);
		vif.awready	= 0;
		vif.wready	= 0;
		vif.bid 	= 0;
		vif.bresp	= 0;
		vif.bvalid	= 0;
		vif.arready	= 0;
		vif.rid 	= 0;
		vif.rdata	= 0;
		vif.rresp	= 0;
		vif.rlast	= 0;
		vif.rvalid	= 0;
		@(negedge vif.arst);
		forever begin
			//@(posedge vif.aclk);
			@(vif.responder_cb);
			// Write Address Channel
			if(vif.awvalid)begin
				vif.awready = 1;
			
				awid_t		= vif.awid;
				awaddr_t	= vif.awaddr;	
				awlen_t		= vif.awlen;	
				awsize_t  	= vif.awsize;	
				awburst_t	= vif.awburst;
				awlock_t	= vif.awlock;	
				awcache_t	= vif.awcache;
				awprot_t  	= vif.awprot;

				wrap_calc(awaddr_t,awlen_t,awsize_t);
			end
			else begin
				vif.awready=0;
			end
			// Write Data Channel
			if(vif.wvalid)begin
				vif.wready = 1;
				
				wid_t 	= vif.wid;
				mem[awaddr_t]	= vif.wdata[7:0];
				mem[awaddr_t+1]	= vif.wdata[15:8];
				mem[awaddr_t+2]	= vif.wdata[23:16];
				mem[awaddr_t+3]	= vif.wdata[31:24];
				
				
				if(awburst_t inside {INCR,WRAP})begin
					awaddr_t = awaddr_t + (2**awsize_t);
				end
				if(awburst_t == WRAP && awaddr_t >=upper_wrap_boundary)begin
					awaddr_t = lower_wrap_boundary;
				end
				
				wstrb_t = vif.wstrb;
				
				if(vif.wlast) begin
					write_resp(wid_t); // Write Response Channel
				end
			end
			else begin
				vif.wready = 0;
			end
		

			// Read Address Channel
			if(vif.arvalid)begin
				vif.arready=1;

				arid_t		= vif.arid;
				araddr_t	= vif.araddr;	
				arlen_t		= vif.arlen;	
				arsize_t  	= vif.arsize;	
				arburst_t	= vif.arburst;
				arlock_t	= vif.arlock;	
				arcache_t	= vif.arcache;
				arprot_t  	= vif.arprot;	

				wrap_calc(araddr_t,arlen_t,arsize_t);
				// Read Data/Response Channel
				read_data(arid_t);
			end
			else vif.arready=0;
		end
	endtask
	
	// Write Response Channel Task
	task write_resp(bit [3:0]id);
		@(posedge vif.aclk);
		//@(vif.responder_cb);
		vif.bid		= id;
		vif.bresp	= 2'b00;
		vif.bvalid	= 1;
		wait(vif.bready);
		@(posedge vif.aclk);
		//@(vif.responder_cb);
		vif.bid 	= 0;
		vif.bresp	= 0;
		vif.bvalid	= 0;
	endtask

	// Read Data/Response channel Task
	task read_data(bit [3:0]id);
		for(int i=0;i<=arlen_t;i++)begin
			@(posedge vif.aclk);
			//@(vif.responder_cb);
			vif.rid 		= id;
			vif.rdata[7:0]		= mem[araddr_t];
			vif.rdata[15:8]		= mem[araddr_t+1];
			vif.rdata[23:16]	= mem[araddr_t+2];
			vif.rdata[31:24]	= mem[araddr_t+3];
			//araddr_t = araddr_t + 2**arsize_t;
			if(arburst_t inside {INCR,WRAP})begin
				araddr_t = araddr_t + (2**arsize_t);
			end
			if(arburst_t == WRAP && araddr_t >=upper_wrap_boundary)begin
				araddr_t = lower_wrap_boundary;
			end
			vif.rresp	= 2'b00;
			if(i==arlen_t) vif.rlast= 1;
			else vif.rlast = 0;
			vif.rvalid = 1;
			wait(vif.rready);
		end
		@(posedge vif.aclk);
		//@(vif.responder_cb);
		vif.rvalid 	= 0;
		vif.rid		= 0;
		vif.rdata	= 0;
		vif.rresp	= 0;
		vif.rlast	= 0;
	endtask	

	task wrap_calc(bit [31:0]addr,bit [3:0]len,bit [2:0]size);
		int num_bytes,offset;
		num_bytes = (len+1)*(2**size);
		offset = addr%num_bytes;
		lower_wrap_boundary = addr - offset;
		upper_wrap_boundary = lower_wrap_boundary+(num_bytes-1);
	endtask

endclass
