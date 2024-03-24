class mem_gen;
	mem_tx tx;
	bit [`ADDR_WIDTH-1:0]addr_to_write;
	bit [`ADDR_WIDTH-1:0]addr_to_writeQ[$];
	task run();
		$display("GENERATOR RUNNING");
		case(mem_common::testcase)
			"single_wr_rd":begin
				tx=new();
				assert(tx.randomize with {wr_rd_en==1;});
				//tx.print("GEN");
				mem_common::gen2bfm.put(tx);
				addr_to_write= tx.addr;

				tx=new();
				assert(tx.randomize with {wr_rd_en==0; tx.addr == addr_to_write;});
				mem_common::gen2bfm.put(tx);
			end
			"multiple_wr_rd":begin
				for(int i=0;i<mem_common::count;i++)begin
					tx=new();
					assert(tx.randomize with {wr_rd_en==1;});
					addr_to_writeQ.push_back(tx.addr);
					mem_common::gen2bfm.put(tx);
				end
				for(int i=0;i<mem_common::count;i++)begin
					tx=new();
					addr_to_write=addr_to_writeQ.pop_front();
					assert(tx.randomize with {wr_rd_en==0; tx.addr== addr_to_write;});
					mem_common::gen2bfm.put(tx);
				end
			end
		endcase
	endtask
endclass
