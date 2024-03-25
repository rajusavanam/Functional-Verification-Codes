class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	`NEW_COMP

	env env_i;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env_i = env::type_id::create("env_i",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

	function void report_phase(uvm_phase phase);
		`uvm_info("STATUS","BASE_TEST_RUNNING",UVM_NONE);
	endfunction

	task run_phase(uvm_phase phase);
		base_seq seq_i;
		seq_i = base_seq::type_id::create("seq_i");
		phase.raise_objection(this);
		seq_i.start(env_i.agent_i.sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass
