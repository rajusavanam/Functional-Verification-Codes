class mem_sbd;
	mem_tx tx;
	bit [`MEM_WIDTH-1:0]sbd_mem[*];
	task run();
		forever begin
			tx = new();
			mem_common::mon2sbd.get(tx);
			if(tx.wr_rd_en==1)begin
				sbd_mem[tx.addr]=tx.data;
			end
			else begin
				if(sbd_mem[tx.addr]==tx.data)begin
					mem_common::match++;
				end
				else begin
					mem_common::mis_match++;
				end
			end
		end
	endtask
endclass
