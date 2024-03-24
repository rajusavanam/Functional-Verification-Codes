class mem_sbd extends uvm_scoreboard;
	uvm_analysis_imp#(mem_tx,mem_sbd)imp_mem;
	//	mem_tx tx;
	bit [`MEM_WIDTH-1:0]sbd_mem[*];
	`uvm_component_utils(mem_sbd)
	`NEW_COMP
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		imp_mem = new("imp_mem",this);
	endfunction

	function void write(mem_tx tx);
		if(tx.wr_rd_en==1)begin
			sbd_mem[tx.addr]=tx.data;
		end
		else begin
			if(tx.data == sbd_mem[tx.addr])begin
				mem_common::num_matches++;
			end
			else begin
				mem_common::num_mis_matches++;
				`uvm_error("SBD_ERROR",$psprintf("SBD Data do not match read data. SBD_Data= %h, Mem_Data= %h",sbd_mem[tx.addr], tx.data))
			end
		end
	endfunction
endclass
