class alu_cov extends uvm_subscriber#(alu_tx);
	alu_tx tx;
	`uvm_component_utils(alu_cov);

	covergroup cg;
		OPERATONS: coverpoint tx.ope
		{
			bins ADDITION 		= {3'b000};
			bins SUBTRACTION 	= {3'b001};
			bins MULTIPLICATION = {3'b010};
			bins DIVISION 		= {3'b011};
			bins REMAINDER 		= {3'b100};
			bins AND 			= {3'b101};
			bins OR 			= {3'b110};
			bins XOR 			= {3'b111};
		}
	endgroup

	function new(string name="",uvm_component parent);
		super.new(name,parent);
		cg=new();
	endfunction

	function void write(alu_tx t);
		this.tx = t;
		cg.sample();
	endfunction
endclass
