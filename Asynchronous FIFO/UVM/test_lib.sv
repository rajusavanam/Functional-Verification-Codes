class base_test extends uvm_test;
	async_fifo_env env;
	
	`uvm_component_utils(base_test)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		env = async_fifo_env::type_id::create("env",this);	
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
	function void report_phase (uvm_phase phase);
		if(async_fifo_common::num_matches==0||async_fifo_common::num_mis_matches!=0)begin
			`uvm_error("TEST FAILED",$psprintf("Mathces=%0d\tMismatches=%0d",async_fifo_common::num_matches,async_fifo_common::num_mis_matches))
		end
		else begin
			`uvm_info("TEST PASSED",$psprintf("Mathces=%0d\tMismatches=%0d",async_fifo_common::num_matches,async_fifo_common::num_mis_matches),UVM_NONE)
		end
	endfunction
endclass

class wr_only_test extends base_test;
	`uvm_component_utils(wr_only_test)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","wr_count",5);
	endfunction
	
	task run_phase(uvm_phase phase);
		wr_seq wr_seq_i = wr_seq::type_id::create("wr_seq_i");
		phase.raise_objection(this);
		wr_seq_i.start(env.wr_agent.wr_sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

class delayed_wr_only_test extends base_test;
	`uvm_component_utils(delayed_wr_only_test)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","wr_count",5);
	endfunction
endclass

class rd_only_test extends base_test;
	`uvm_component_utils(rd_only_test)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","rd_count",5);
	endfunction
	
	task run_phase(uvm_phase phase);
		rd_seq rd_seq_i = rd_seq::type_id::create("rd_seq_i");
		phase.raise_objection(this);
		rd_seq_i.start(env.rd_agent.rd_sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

class n_wr_n_rd_test extends base_test;
	`uvm_component_utils(n_wr_n_rd_test);
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","wr_count",10);
		uvm_config_db#(int)::set(this,"*","rd_count",10);
	endfunction

	task run_phase(uvm_phase phase);
		wr_seq wr_seq_i = wr_seq::type_id::create("wr_seq_i");
		rd_seq rd_seq_i = rd_seq::type_id::create("rd_seq_i");
		phase.raise_objection(this);
		wr_seq_i.start(env.wr_agent.wr_sqr);
		rd_seq_i.start(env.rd_agent.rd_sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

class full_wr_rd_test extends base_test;
	`uvm_component_utils(full_wr_rd_test);
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","wr_count",`DEPTH);
		uvm_config_db#(int)::set(this,"*","rd_count",`DEPTH);
	endfunction

	task run_phase(uvm_phase phase);
		wr_seq wr_seq_i = wr_seq::type_id::create("wr_seq_i");
		rd_seq rd_seq_i = rd_seq::type_id::create("rd_seq_i");
		phase.raise_objection(this);
		wr_seq_i.start(env.wr_agent.wr_sqr);
		rd_seq_i.start(env.rd_agent.rd_sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

class wr_error_test extends full_wr_rd_test;
	`uvm_component_utils(wr_error_test);
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","wr_count",`DEPTH+5);
		uvm_config_db#(int)::set(this,"*","rd_count",`DEPTH);
	endfunction
endclass

class rd_error_test extends full_wr_rd_test;
	`uvm_component_utils(rd_error_test);
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","wr_count",`DEPTH);
		uvm_config_db#(int)::set(this,"*","rd_count",`DEPTH+5);
	endfunction
endclass

class wr_rd_error_test extends full_wr_rd_test;
	`uvm_component_utils(wr_rd_error_test);
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","wr_count",`DEPTH+5);
		uvm_config_db#(int)::set(this,"*","rd_count",`DEPTH+5);
	endfunction
endclass

class concurrent_wr_rd_test extends base_test;
	`uvm_component_utils(concurrent_wr_rd_test);
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","wr_count",20);
		uvm_config_db#(int)::set(this,"*","rd_count",20);
	endfunction

	task run_phase(uvm_phase phase);
		wr_delay_seq wr_seq_i = wr_delay_seq::type_id::create("wr_seq_i");
		rd_delay_seq rd_seq_i = rd_delay_seq::type_id::create("rd_seq_i");
		phase.raise_objection(this);
		fork
			wr_seq_i.start(env.wr_agent.wr_sqr);
			rd_seq_i.start(env.rd_agent.rd_sqr);
		join
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

class top_wr_rd_test extends base_test;
	`uvm_component_utils(top_wr_rd_test)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(this,"*","wr_count",`DEPTH);
		uvm_config_db#(int)::set(this,"*","rd_count",`DEPTH);
	endfunction

	task run_phase(uvm_phase phase);
		top_wr_rd_seq wr_rd_seq_i = top_wr_rd_seq::type_id::create("wr_rd_seq_i");
		phase.raise_objection(this);
		wr_rd_seq_i.start(env.top_sqr_i);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

