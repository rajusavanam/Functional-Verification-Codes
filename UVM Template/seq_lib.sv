class base_seq extends uvm_sequence#(tx);
	`uvm_object_utils(base_seq)
	`NEW_OBJ

	task body();
		`uvm_do(req);
	endtask
endclass
