class wr_base_seq extends uvm_sequence#(wr_tx);
	`uvm_object_utils(wr_base_seq)
	`NEW_OBJ

	int wr_count;
	uvm_phase phase;
	task pre_body();
		phase = get_starting_phase();
		if(phase!=null)phase.raise_objection(this);
	endtask
	task post_body();
		if(phase!=null)phase.drop_objection(this);
	endtask
endclass
class wr_seq extends wr_base_seq;
	`uvm_object_utils(wr_seq)
	`NEW_OBJ

	task body();
		uvm_config_db#(int)::get(null,get_full_name(),"wr_count",wr_count);
		repeat(wr_count) `uvm_do(req);
	endtask
endclass

class wr_delay_seq extends wr_base_seq;
	`uvm_object_utils(wr_delay_seq)
	`NEW_OBJ

	task body();
		int delay;
		uvm_config_db#(int)::get(null,get_full_name(),"wr_count",wr_count);
		repeat(wr_count)begin
			delay=$urandom_range(1,`WR_MAX_DELAY);
		 	`uvm_do_with(req,{req.wr_delay==delay;});
		end
	endtask
endclass
