class sy_fifo_tx;

	rand bit wr_en;
	rand bit rd_en;
	rand bit [`WIDTH-1:0]data;
	
	constraint enable{rd_en == ~wr_en;}

	function void print(string name="default");
		if(wr_en) $display("\t @ %0dns\t\tWriting \t\tData= %h",$time,data);
		if(rd_en) $display("\t @ %0dns\t\tReading \t\tData= %h",$time,data);
	endfunction

endclass
