`uvm_analysis_imp_decl(_wr)
`uvm_analysis_imp_decl(_rd)
class async_fifo_sbd extends uvm_scoreboard;
	`uvm_component_utils(async_fifo_sbd)
	`NEW_COMP

	wr_tx wr_tx_i,wr_txQ[$];
	rd_tx rd_tx_i,rd_txQ[$];

	uvm_analysis_imp_wr#(wr_tx,async_fifo_sbd)wr_imp;
	uvm_analysis_imp_rd#(rd_tx,async_fifo_sbd)rd_imp;

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		wr_imp = new("wr_imp",this);
		rd_imp = new("rd_imp",this);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			wait(wr_txQ.size()>0 && rd_txQ.size()>0);
			wr_tx_i=wr_txQ.pop_front();
			rd_tx_i=rd_txQ.pop_front();
			if(wr_tx_i.wr_data==rd_tx_i.rd_data)begin
				async_fifo_common::num_matches++;
			end
			else begin
				async_fifo_common::num_mis_matches++;
			end
		end
	endtask

	function void write_wr(wr_tx t);
		$cast(wr_tx_i,t);
		wr_txQ.push_back(wr_tx_i);
	endfunction

	function void write_rd(rd_tx t);
		$cast(rd_tx_i,t);
		rd_txQ.push_back(rd_tx_i);
	endfunction
endclass
