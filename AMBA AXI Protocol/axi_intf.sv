interface axi_intf (input reg aclk,arst);
	// Write Address Channel Signals
	logic [3:0] awid;
	logic [31:0] awaddr;
	logic [3:0] awlen;
	logic [2:0] awsize;
	logic [1:0] awburst;
	logic [1:0] awlock;
	logic [3:0] awcache;
	logic [2:0] awprot;
	logic awvalid;
	logic awready;

	// Write Data Channel Signals
	logic [3:0] wid;
	logic [31:0]wdata;
	logic [3:0] wstrb;
	logic wlast;
	logic wvalid;
	logic wready;

	// Write Response Channel Signals
	logic [3:0]bid;
	logic [1:0]bresp;
	logic bvalid;
	logic bready;

	// Read Address Channel Signals
	logic [3:0] arid;
	logic [31:0] araddr;
	logic [3:0] arlen;
	logic [2:0] arsize;
	logic [1:0] arburst;
	logic [1:0] arlock;
	logic [3:0] arcache;
	logic [2:0] arprot;
	logic arvalid;
	logic arready;

	// Read Data/Response Channel Signals
	logic [3:0] rid;
	logic [31:0]rdata;
	logic [1:0]rresp;
	logic rlast;
	logic rvalid;
	logic rready;

	clocking driver_cb@(posedge aclk);
		default input #0 output #1;
		// Write Address Channel Signals
		output awid;
		output awaddr;
		output awlen;
		output awsize;
		output awburst;
		output awlock;
		output awcache;
		output awprot;
		output awvalid;
		input awready;

		// Write Data Channel Signals
		output wid;
		output wdata;
		output wstrb;
		output wlast;
		output wvalid;
		input wready;

		// Write Response Channel Signals
		input bid;
		input bresp;
		input bvalid;
		output bready;

		// Read Address Channel Signals
		output arid;
		output araddr;
		output arlen;
		output arsize;
		output arburst;
		output arlock;
		output arcache;
		output arprot;
		output arvalid;
		input arready;

		// Read Data/Response Channel Signals
		input rid;
		input rdata;
		input rresp;
		input rlast;
		input rvalid;
		output rready;
	endclocking

	clocking responder_cb@(posedge aclk);
		default input #0 output #1;
		
		// Write Address Channel Signals
		input awid;
		input awaddr;
		input awlen;
		input awsize;
		input awburst;
		input awlock;
		input awcache;
		input awprot;
		input awvalid;
		output awready;

		// Write Data Channel Signals
		input wid;
		input wdata;
		input wstrb;
		input wlast;
		input wvalid;
		output wready;

		// Write Response Channel Signals
		output bid;
		output bresp;
		output bvalid;
		input bready;

		// Read Address Channel Signals
		input arid;
		input araddr;
		input arlen;
		input arsize;
		input arburst;
		input arlock;
		input arcache;
		input arprot;
		input arvalid;
		output arready;

		// Read Data/Response Channel Signals
		output rid;
		output rdata;
		output rresp;
		output rlast;
		output rvalid;
		input rready;
	endclocking

	clocking mon_cb@(posedge aclk);
		default input #1;
		// Write Address Channel Signals
		input awid;
		input awaddr;
		input awlen;
		input awsize;
		input awburst;
		input awlock;
		input awcache;
		input awprot;
		input awvalid;
		input awready;

		// Write Data Channel Signals
		input wid;
		input wdata;
		input wstrb;
		input wlast;
		input wvalid;
		input wready;

		// Write Response Channel Signals
		input bid;
		input bresp;
		input bvalid;
		input bready;

		// Read Address Channel Signals
		input arid;
		input araddr;
		input arlen;
		input arsize;
		input arburst;
		input arlock;
		input arcache;
		input arprot;
		input arvalid;
		input arready;

		// Read Data/Response Channel Signals
		input rid;
		input rdata;
		input rresp;
		input rlast;
		input rvalid;
		input rready;
	endclocking

	// Assertions

	property handshake(valid,ready,MIN,MAX);
		@(posedge aclk) valid == 1 |-> ##[MIN:MAX]ready==1;
	endproperty

	property address(valid,address);
		@(posedge aclk)valid ==1 |-> not($isunknown(address));
	endproperty

	property data(valid,data);
		@(posedge aclk)valid == 1 |-> not($isunknown(data));
	endproperty

	AW_HANDSHAKE:assert property(handshake(awvalid,awready,0,5));
	W_HANDSHAKE:assert property(handshake(wvalid,wready,0,3));
	B_HANDSHAKE:assert property(handshake(bvalid,bready,0,5));
	AR_HANDSHAKE:assert property(handshake(arvalid,arready,0,5));
	R_HANDSHAKE:assert property(handshake(rvalid,rready,0,5));
	AW_ADDRESS:assert property(address(awvalid,awaddr));
	AR_ADDRESS:assert property(address(arvalid,araddr));
	W_DATA:assert property(data(wvalid,wdata));
	R_DATA:assert property(data(rvalid,rdata));
endinterface
