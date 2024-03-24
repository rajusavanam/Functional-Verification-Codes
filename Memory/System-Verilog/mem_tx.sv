class mem_tx;
	rand bit wr_rd_en;
	rand bit [`ADDR_WIDTH-1:0]addr;
	rand bit [`MEM_WIDTH-1:0]data;

	function void print(string name = "TX Fields");
		if(wr_rd_en==1) $display("\t %0d \tWR_RD= %b\t\tWriting into %s\t\tADDR= %h\t\tDATA= %h",$time,wr_rd_en,name,addr,data);
		else $display("\t %0d \tWR_RD= %b\t\tReading from %s\t\tADDR= %h\t\tDATA= %h",$time,wr_rd_en,name,addr,data);
	endfunction
endclass
