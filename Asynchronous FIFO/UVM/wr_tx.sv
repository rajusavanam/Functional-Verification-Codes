class wr_tx extends uvm_sequence_item;
	
	rand bit [`WIDTH-1:0]wr_data;
	rand int wr_delay;

	`uvm_object_utils_begin(wr_tx)
		`uvm_field_int(wr_data,UVM_ALL_ON)
		`uvm_field_int(wr_delay,UVM_ALL_ON)
	`uvm_object_utils_end

	`NEW_OBJ

	constraint wr_delay_c{
		soft wr_delay==0;
	}

endclass
