class rd_base_seq extends uvm_sequence#(rd_tx);
	`uvm_object_utils(rd_base_seq)
	`NEW_OBJ

	int rd_count;
	uvm_phase phase; 
	task pre_body();
		phase = get_starting_phase();
		if(phase!=null)phase.raise_objection(this);
	endtask
	task post_body();
		if(phase!=null)phase.drop_objection(this);
	endtask
endclass
class rd_seq extends rd_base_seq;
	`uvm_object_utils(rd_seq)
	`NEW_OBJ

	task body();
		uvm_config_db#(int)::get(null,get_full_name(),"rd_count",rd_count);
		repeat(rd_count) `uvm_do(req);
	endtask	
endclass

class rd_delay_seq extends rd_base_seq;
	`uvm_object_utils(rd_delay_seq)
	`NEW_OBJ

	task body();
		int delay;
		uvm_config_db#(int)::get(null,get_full_name(),"rd_count",rd_count);
		repeat(rd_count) begin
			delay=$urandom_range(1,`RD_MAX_DELAY);
		 	`uvm_do_with(req,{req.rd_delay==delay;});
		end
	endtask
endclass
