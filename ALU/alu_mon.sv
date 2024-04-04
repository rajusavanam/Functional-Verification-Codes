class alu_mon extends uvm_monitor;
	alu_tx tx;
	virtual alu_intfc vif;
	uvm_analysis_port#(alu_tx)ap_port;
	`uvm_component_utils(alu_mon)
	`NEW_COMP
	function void build_phase(uvm_phase phase);
		ap_port = new("ap_port",this);
		uvm_config_db#(virtual alu_intfc)::get(null,"","ALU_INTFC",vif);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
		/*	@(posedge vif.clk_i)
			if(vif.valid_i==1 && vif.ready_o==1)begin
				tx = alu_tx::type_id::create("tx");
				tx.ope_a = vif.operand_a;
				tx.ope_b = vif.operand_b;
				tx.ope = vif.operation;
				ap_port.write(tx);
			end
		*/
			@(vif.mon_cb)
			if(vif.mon_cb.valid_i==1 && vif.mon_cb.ready_o==1)begin
				tx = alu_tx::type_id::create("tx");
				tx.ope_a = vif.mon_cb.operand_a;
				tx.ope_b = vif.mon_cb.operand_b;
				tx.ope = vif.mon_cb.operation;
				ap_port.write(tx);
			end
		end
	endtask
endclass
