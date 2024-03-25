`uvm_analysis_imp_decl(_master)
`uvm_analysis_imp_decl(_slave)
class axi_sbd extends uvm_scoreboard;
	`uvm_component_utils(axi_sbd)
	`NEW_COMP

	uvm_analysis_imp_master #(axi_tx,axi_sbd)m_imp;
	uvm_analysis_imp_slave #(axi_tx,axi_sbd)s_imp;

	axi_tx tx,m_tx,s_tx,m_txQ[$],s_txQ[$];

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_imp = new("m_imp",this);
		s_imp = new("s_imp",this);
	endfunction
	task run_phase(uvm_phase phase);
		forever begin
			wait(m_txQ.size>0 && s_txQ.size >0);
			m_tx = m_txQ.pop_front();
			s_tx = s_txQ.pop_front();
			if(m_tx.compare(s_tx))begin
				axi_common::num_matches++;
			end
			else axi_common::num_mismatches++;
		end
	endtask

	function void write_master(axi_tx t);
		$cast(tx,t);
		m_txQ.push_back(tx);
	endfunction

	function void write_slave(axi_tx t);
		$cast(tx,t);
		s_txQ.push_back(tx);
	endfunction
endclass
