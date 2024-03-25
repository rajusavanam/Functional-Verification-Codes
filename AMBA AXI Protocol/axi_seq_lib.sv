class base_seq extends uvm_sequence#(axi_tx);
	`uvm_object_utils(base_seq)
	`NEW_OBJ

	uvm_phase phase;
	axi_tx tx,tx_t,txQ[$];
	task pre_body();
		phase = get_starting_phase();
		if(phase!=null)begin
			phase.raise_objection(this);
		end
	endtask

	task post_body();
		if(phase!=null)begin
			phase.drop_objection(this);
		end
	endtask
endclass

class wr_seq extends base_seq;
	`uvm_object_utils(wr_seq)
	`NEW_OBJ
	
	task body();
		axi_common::tx_count = axi_common::count;
		repeat(axi_common::count) begin
			`uvm_do_with(req,{req.wr_rd==1;})
		end
	endtask
endclass

class wr_rd_seq extends base_seq;
	`uvm_object_utils(wr_rd_seq)
	`NEW_OBJ
	task body();
		axi_common::tx_count = 2*axi_common::count;
		repeat(axi_common::count)begin
			`uvm_do_with(req,{req.wr_rd==1;})
			tx_t = new req;
			txQ.push_back(tx_t);
		end
		repeat(axi_common::count)begin
			tx_t = txQ.pop_front();
			`uvm_do_with(req,{req.wr_rd==0;
							  req.id == tx_t.id;
						  	  req.addr == tx_t.addr;
						  	  req.size == tx_t.size;
					  		  req.len == tx_t.len;
					  	  	  req.lock == tx_t.lock;
							  req.prot == tx_t.prot;
							  req.cache == tx_t.cache;
							  req.burst== tx_t.burst;})

		end
	endtask
endclass
