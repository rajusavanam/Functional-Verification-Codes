class top_base_seq extends uvm_sequence;
	`uvm_object_utils(top_base_seq)
	`NEW_OBJ
	
	uvm_phase phase;
	task pre_body();
		phase = get_starting_phase();
		if(phase!=null)phase.raise_objection(this);
	endtask
	task post_body();
		if(phase!=null)phase.drop_objection(this);
	endtask
endclass

class top_wr_rd_seq extends top_base_seq;
	`uvm_object_utils(top_wr_rd_seq)
	`NEW_OBJ

	`uvm_declare_p_sequencer(top_sqr)
	
	task body();
		wr_seq top_wr_seq_i;
		rd_seq top_rd_seq_i;

		`uvm_do_on(top_wr_seq_i,p_sequencer.wr_sqr)
		`uvm_do_on(top_rd_seq_i,p_sequencer.rd_sqr)
	endtask
endclass
