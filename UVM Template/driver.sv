class driver extends uvm_driver#(tx);
	`uvm_component_utils(driver)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
			req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(tx t);
		//		
	endtask
endclass
