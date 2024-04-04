class alu_tx extends uvm_sequence_item;
	
	rand int ope_a;
	rand int ope_b;
	rand logic [2:0]ope;
	int result;
	
	`uvm_object_utils_begin(alu_tx)
		`uvm_field_int(ope_a,UVM_ALL_ON);
		`uvm_field_int(ope_b,UVM_ALL_ON);
		`uvm_field_int(ope,UVM_ALL_ON);
		`uvm_field_int(result,UVM_ALL_ON);
	`uvm_object_utils_end
	
	`NEW_OBJ

	constraint operands{
		ope_a inside {[0:1000]} && ope_b inside {[0:1000]};}
	constraint ope_c{ 
			//if(ope inside {1,3,4}) {
			//	ope_a >= ope_b; }
			if(ope == {4}) { ope_b != 0; }
			}
endclass
