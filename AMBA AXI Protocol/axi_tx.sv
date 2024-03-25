class axi_tx extends uvm_sequence_item;

	rand bit wr_rd;
	rand bit [3:0] id;
	rand bit [31:0] addr;
	rand bit [3:0] len;
	rand bit [2:0] size;
	rand bit [2:0] prot;
	rand bit [3:0] cache;
	rand bit [31:0] data[$];
	rand burst_t burst;
	rand lock_t lock;
		 resp_t resp;

	`uvm_object_utils_begin(axi_tx)
		`uvm_field_int(wr_rd,UVM_ALL_ON)
		`uvm_field_int(id,UVM_ALL_ON)
		`uvm_field_int(addr,UVM_ALL_ON)
		`uvm_field_int(len,UVM_ALL_ON)
		`uvm_field_int(size,UVM_ALL_ON)
		`uvm_field_int(prot,UVM_ALL_ON)
		`uvm_field_int(cache,UVM_ALL_ON)
		`uvm_field_queue_int(data,UVM_ALL_ON)
		`uvm_field_enum(burst_t,burst,UVM_ALL_ON)
		`uvm_field_enum(lock_t,lock,UVM_ALL_ON)
		`uvm_field_enum(resp_t,resp,UVM_ALL_ON)
	`uvm_object_utils_end
	`NEW_OBJ

	//constraint len_c
	//{
	//	len != 0;
	//}
	constraint data_c
	{
		data.size() == len+1;
	}
	constraint size_c
	{
		soft size == 2;
	}
	constraint alligned_c
	{
		soft addr%(2**size) == 0;
	}
	constraint not_select_c
	{
		burst != RESERVED_BURST;
		lock != RESERVED_LOCK;
	}
	constraint burst_c
	{
		soft burst inside {INCR,WRAP};
	}

endclass
