class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	`NEW_COMP
	
	axi_env env;

	function void build_phase (uvm_phase phase);
		`uvm_info("AXI_BASE_TEST","Inside Build Phase of UVM Base Test",UVM_HIGH)
		super.build_phase(phase);
		env = axi_env::type_id::create("env",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

	function void report_phase(uvm_phase phase);
		if(axi_common::num_matches==axi_common::tx_count && axi_common::num_mismatches==0)begin
			`uvm_info("TEST_PASSED",$psprintf("Num Matches = %0d,\t Num Mismatches = %0d\n",axi_common::num_matches,axi_common::num_mismatches),UVM_NONE);
		end
		else begin
			`uvm_info("TEST_FAILED",$psprintf("Num Matches = %0d,\t Num Mismatches = %0d\n",axi_common::num_matches,axi_common::num_mismatches),UVM_NONE);
		end
	endfunction

endclass

class test_wr extends base_test;
	`uvm_component_utils(test_wr)
	`NEW_COMP

	task run_phase(uvm_phase phase);
		// Instantiate the sequence
		wr_seq wr_seq_i;
		// Create object handle for the sequence
		wr_seq_i = wr_seq::type_id::create("wr_seq_i");
		// Raise Objection
		phase.raise_objection(this);
		// Start the sequence
		wr_seq_i.start(env.magent.sqr);
		// Set Drain Time
		phase.phase_done.set_drain_time(this,100);
		// Drop the objection
		phase.drop_objection(this);
	endtask
endclass

class test_wr_rd extends base_test;
	`uvm_component_utils(test_wr_rd)
	`NEW_COMP

	task run_phase(uvm_phase phase);
		// Instantiate the sequence
		wr_rd_seq wr_rd_seq_i;
		// Create object handle for the sequence
		wr_rd_seq_i = wr_rd_seq::type_id::create("wr_rd_seq_i");
		// Raise Objection
		phase.raise_objection(this);
		// Start the sequence
		wr_rd_seq_i.start(env.magent.sqr);
		// Set Drain Time
		phase.phase_done.set_drain_time(this,100);
		// Drop the objection
		phase.drop_objection(this);
	endtask
endclass
