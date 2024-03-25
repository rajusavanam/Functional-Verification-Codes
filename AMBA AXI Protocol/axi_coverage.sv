class axi_coverage extends uvm_subscriber#(axi_tx);
	`uvm_component_utils(axi_coverage)
	
	axi_tx tx;

	covergroup cg;
		WR_RD_CP:coverpoint tx.wr_rd
		{
			bins WR = {1'b1}; 
			bins RD = {1'b0}; 
		}
		ID_CP: coverpoint tx.id
		{
			option.auto_bin_max=4;
		}
		ADDR_CP: coverpoint tx.addr
		{
			option.auto_bin_max=4;
		}
		LEN_CP: coverpoint tx.len
		{
			option.auto_bin_max=4;
		}
		BURST_CP: coverpoint tx.burst
		{
			bins FIXED = {2'b00};
			bins INCR = {2'b01};
			bins WRAP = {2'b10};
			illegal_bins RESERVED_BURST = {2'b11};
		}
		SIZE_CP: coverpoint tx.size
		{
			bins TRANSFER_BYTE_1   = {3'b000};
			bins TRANSFER_BYTE_2   = {3'b001};
			bins TRANSFER_BYTE_4   = {3'b010};
			bins TRANSFER_BYTE_8   = {3'b011};
			bins TRANSFER_BYTE_16  = {3'b100};
			bins TRANSFER_BYTE_32  = {3'b101};
			bins TRANSFER_BYTE_64  = {3'b110};
			bins TRANSFER_BYTE_128 = {3'b111};
		}
		PROT_CP:coverpoint tx.prot
		{
			option.auto_bin_max=4;	
		}
		CACHE_CP: coverpoint tx.cache
		{
			option.auto_bin_max=4;
		}
		LOCK_CP: coverpoint tx.lock
		{
			bins NORAML 		= {2'b00};
			bins EXCLUSIVE 		= {2'b01};
			bins LOCKED  		= {2'b10};
			illegal_bins RESERVED_LOCK	= {2'b11};
		}
		RESP_CP:coverpoint tx.resp
		{
			bins OKAY 	= {2'b00};
			bins EXOKAY = {2'b01};
			bins SLVERR = {2'b10};
			bins DECERR = {2'b11};
		}
	endgroup

	function new(string name,uvm_component parent);
		super.new(name,parent);
		cg = new();
	endfunction

	function void write (axi_tx t);
		$cast(tx,t);
		cg.sample();
	endfunction
endclass
