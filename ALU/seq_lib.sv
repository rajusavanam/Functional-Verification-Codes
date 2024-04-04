class base_seq extends uvm_sequence#(alu_tx);
	alu_tx tx;
	`uvm_object_utils(base_seq)
	`NEW_OBJ
	uvm_phase phase;
	task pre_body();
		phase = get_starting_phase();
		if(phase!=null)begin
			phase.raise_objection(this);
		end
	endtask
	task body();
		int count;
		uvm_config_db#(int)::get(null,get_full_name(),"COUNT",count);
		repeat(count)begin
			`uvm_do(req);
			$cast(tx,req);
		end
	endtask
	task post_body();
		if(phase!=null)begin
			phase.drop_objection(this);
		end
	endtask
endclass
