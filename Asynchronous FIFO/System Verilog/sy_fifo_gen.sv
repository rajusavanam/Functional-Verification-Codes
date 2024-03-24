class sy_fifo_gen;
	sy_fifo_tx tx;
	
	task run();
		$display("\nTestcase=%s\n",sy_fifo_common::testcase);
		case(sy_fifo_common::testcase)
			"wr_rd_all":begin
							sy_fifo_common::tx_count = 2*sy_fifo_common::count;
							repeat(sy_fifo_common::count)begin
								//Write Enabled
								tx=new();
								assert(tx.randomize() with {tx.wr_en==1;});
								sy_fifo_common::gen2bfm.put(tx);
							end

							repeat(sy_fifo_common::count)begin
								//Read Enabled
								tx=new();
								assert(tx.randomize() with {tx.rd_en==1;});
								sy_fifo_common::gen2bfm.put(tx);
							end
						end
			"full_error":begin // Writing More than that of Allocated depth without performing read
							sy_fifo_common::tx_count = sy_fifo_common::count;
							repeat(sy_fifo_common::count+10)begin
								//Write Enabled
								tx=new();
								assert(tx.randomize() with {tx.wr_en==1;});
								sy_fifo_common::gen2bfm.put(tx);
							end
						end
			"empty_error":begin // Reading empty locations/empty data which is previously not written
							sy_fifo_common::tx_count = sy_fifo_common::count;
							repeat(sy_fifo_common::count)begin
								//Read Enabled
								tx=new();
								assert(tx.randomize() with {tx.rd_en==1;});
								sy_fifo_common::gen2bfm.put(tx);
							end
						end
			"wr_rd_concurrent":begin
						sy_fifo_common::tx_count = 2*sy_fifo_common::count;
						fork
							repeat(sy_fifo_common::count)begin
								//Write Enable
								tx=new();
								assert(tx.randomize() with {tx.wr_en==1;});
								sy_fifo_common::gen2bfm.put(tx);
								//Read Enable
								tx=new();
								assert(tx.randomize() with {tx.rd_en==1;});
								sy_fifo_common::gen2bfm.put(tx);
							end
						join
						end
		endcase
	endtask
endclass
