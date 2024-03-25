class tx extends uvm_sequence_item;

	rand int number;

	`uvm_object_utils_begin(tx)
		`uvm_field_int(number,UVM_ALL_ON)
	`uvm_object_utils_end
	`NEW_OBJ	
endclass
