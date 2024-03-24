class rd_tx extends uvm_sequence_item;
	rand bit [`WIDTH-1:0]rd_data;
	rand int rd_delay;

	`uvm_object_utils_begin(rd_tx)
		`uvm_field_int(rd_data,UVM_ALL_ON)
		`uvm_field_int(rd_delay,UVM_ALL_ON)
	`uvm_object_utils_end

	`NEW_OBJ

	constraint rd_delay_c{
		soft rd_delay==0;
	}
endclass
