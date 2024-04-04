class alu_drv extends uvm_driver#(alu_tx);
	alu_tx tx;
	virtual alu_intfc vif;
	`uvm_component_utils(alu_drv)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(virtual alu_intfc)::get(null,"","ALU_INTFC",vif);
	endfunction
	
	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
			req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(alu_tx tx);
		/*@(posedge vif.clk_i)
		vif.valid_i<=1;
		vif.operand_a<=tx.ope_a;
		vif.operand_b<=tx.ope_b;
		vif.operation<=tx.ope;
		wait(vif.ready_o==1);
		@(posedge vif.clk_i)*/
		@(vif.drv_cb)
		vif.drv_cb.valid_i<=1;
		vif.drv_cb.operand_a<=tx.ope_a;
		vif.drv_cb.operand_b<=tx.ope_b;
		vif.drv_cb.operation<=tx.ope;
		wait(vif.drv_cb.ready_o==1);
		@(vif.drv_cb)
		top.reset_signals();
	endtask
endclass
