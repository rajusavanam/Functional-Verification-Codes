class mem_base_test extends uvm_test;
	mem_env env;
	`uvm_component_utils(mem_base_test)
	`NEW_COMP

	function void build_phase (uvm_phase phase);
		env = mem_env::type_id::create("env",this);
		//`uvm_info("CURRENT_LINE",$psprintf("BUILD Phase of MEM_BASE_TEST"),UVM_NONE);
	endfunction

	function void connect_phase (uvm_phase phase);
		//`uvm_info("CURRENT_LINE",$psprintf("CONNECT Phase of MEM_BASE_TEST"),UVM_NONE);
	endfunction

	function void end_of_elaboration_phase (uvm_phase phase);
		uvm_top.print_topology();
		//`uvm_info("CURRENT_LINE",$psprintf("END OF ELABORATION Phase of MEM_BASE_TEST"),UVM_NONE);
	endfunction

	function void start_of_simulation_phase (uvm_phase phase);
		//`uvm_info("CURRENT_LINE",$psprintf("START OF SIMULATION Phase of MEM_BASE_TEST"),UVM_NONE);
	endfunction

	task run_phase (uvm_phase phase);
		//`uvm_info("CURRENT_LINE",$psprintf("RUN Phase of MEM_BASE_TEST"),UVM_NONE);
	endtask

	function void extract_phase (uvm_phase phase);
		//`uvm_info("CURRENT_LINE",$psprintf("EXTRACT Phase of MEM_BASE_TEST"),UVM_NONE);
	endfunction

	function void check_phase (uvm_phase phase);
		//`uvm_info("CURRENT_LINE",$psprintf("CHECK Phase of MEM_BASE_TEST"),UVM_NONE);
	endfunction

	function void report_phase (uvm_phase phase);
		if(mem_common::num_matches == mem_common::total_tx_count && mem_common::num_mis_matches == 0)begin
			`uvm_info("STATUS",$psprintf("Testcase Passed: Total TX COUNT = %0d, MATCHES = %0d, MISMATCHES = %0d",mem_common::total_tx_count,mem_common::num_matches,mem_common::num_mis_matches),UVM_NONE);
		end
		else begin
			`uvm_error("STATUS",$psprintf("Testcase FAILED: Total TX COUNT = %0d, MATCHES = %0d, MISMATCHES = %0d",mem_common::total_tx_count,mem_common::num_matches,mem_common::num_mis_matches));
		end
	endfunction
endclass
 
class mem_wr_rd_test extends mem_base_test;
	`uvm_component_utils(mem_wr_rd_test)
	`NEW_COMP
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		mem_wr_rd_seq wr_rd_seq;
		wr_rd_seq = mem_wr_rd_seq::type_id::create("wr_rd_seq");

		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,200);
		wr_rd_seq.start(env.agent.sqr);
		phase.drop_objection(this);
	endtask
endclass

class mem_n_wr_n_rd_test extends mem_base_test;
	`uvm_component_utils(mem_n_wr_n_rd_test)
	`NEW_COMP
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	task run_phase(uvm_phase phase);
		mem_n_wr_n_rd_seq wr_rd_seq;
		wr_rd_seq = mem_n_wr_n_rd_seq::type_id::create("wr_rd_seq");

		phase.raise_objection(this);
		wr_rd_seq.start(env.agent.sqr);
		#50;
		phase.drop_objection(this);
	endtask
endclass
