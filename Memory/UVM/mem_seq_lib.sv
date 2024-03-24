class mem_wr_rd_seq extends uvm_sequence#(mem_tx);
	mem_tx tx;
	`uvm_object_utils(mem_wr_rd_seq)
	`NEW_OBJ
//	task pre_body();
//		`uvm_info("CHECK","PRE BODY",UVM_NONE);
//	endtask
	task body();
		`uvm_do_with(req,{req.wr_rd_en==1'b1;});
		$cast(tx,req);
		`uvm_do_with(req,{req.wr_rd_en==1'b0;req.addr == tx.addr;});
	endtask
//	task post_body();
//		`uvm_info("CHECK","PRE BODY",UVM_NONE);
//	endtask
endclass

class mem_n_wr_n_rd_seq extends uvm_sequence#(mem_tx);
	mem_tx tx;
	mem_tx txQ[$];

	`uvm_object_utils(mem_n_wr_n_rd_seq)
	`NEW_OBJ
	task body();
		int count;
		uvm_resource_db#(int)::read_by_name("GLOBAL","COUNT",count,null);
		repeat(count)begin
			`uvm_do_with(req,{req.wr_rd_en==1'b1;});
			$cast(tx,req);
			txQ.push_back(tx);
		end
		repeat(count)begin
			tx = txQ.pop_front();
			`uvm_do_with(req,{req.wr_rd_en==1'b0;req.addr == tx.addr;});
		end
	endtask			
endclass
