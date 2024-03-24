class mem_cov extends uvm_subscriber#(mem_tx);
	mem_tx tx;
	`uvm_component_utils(mem_cov);
	
	covergroup cg;
		ADDR:coverpoint tx.addr
		{
			option.auto_bin_max = 6;
		}
		WR_RD:coverpoint tx.wr_rd_en
		{
			bins WRITE = {1'b1};
			bins READ = {1'b0};
		}
		ADDR_X_WR_RD:cross ADDR,WR_RD;
	endgroup

	function new(string name,uvm_component parent);
		super.new(name,parent);
		cg = new();
	endfunction

	function void write(mem_tx t);
		this.tx = t;
		cg.sample();
	endfunction
endclass
