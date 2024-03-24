class async_fifo_wr_cov extends uvm_subscriber#(wr_tx);
	`uvm_component_utils(async_fifo_wr_cov)
	wr_tx tx;

	covergroup wr_cg;
		WR_DELAY:coverpoint tx.wr_delay
		{
			bins ZERO={0};
			bins LOW={[1:5]};
			bins HIGH = {[6:$]};
		}
	endgroup

	function new(string name="",uvm_component parent);
		super.new(name,parent);
		wr_cg=new();
	endfunction

	function void write(wr_tx t);
		$cast(tx,t);
		wr_cg.sample();
	endfunction
endclass
