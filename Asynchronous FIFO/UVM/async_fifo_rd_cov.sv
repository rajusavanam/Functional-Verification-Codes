class async_fifo_rd_cov extends uvm_subscriber#(rd_tx);
	`uvm_component_utils(async_fifo_rd_cov)
	rd_tx tx;

	covergroup rd_cg;
		RD_DELAY:coverpoint tx.rd_delay
		{
			bins ZERO={0};
			bins LOW={[1:5]};
			bins HIGH = {[6:$]};
		}
	endgroup

	function new(string name="",uvm_component parent);
		super.new(name,parent);
		rd_cg=new();
	endfunction

	function void write(rd_tx t);
		$cast(tx,t);
		rd_cg.sample();
	endfunction
endclass
