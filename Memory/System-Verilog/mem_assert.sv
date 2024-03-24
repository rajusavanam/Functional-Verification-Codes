module mem_assert(clk_i,rst_i,wr_rd_en_i,valid_i,addr_i,wdata_i,ready_o,rdata_o);

input clk_i;
input rst_i;
input wr_rd_en_i;
input valid_i;
input [`ADDR_WIDTH-1:0]addr_i;
input [`MEM_WIDTH-1:0]wdata_i;
input ready_o;
input [`MEM_WIDTH-1:0]rdata_o;

property handshake;
	@(posedge clk_i)valid_i==1 |=> ready_o==1;
endproperty
HANDSHAKE:assert property(handshake);

property wr_rd_assert;
	@(posedge clk_i)valid_i==1 && ready_o==1 |-> wr_rd_en_i==1 || wr_rd_en_i==0;
endproperty
WR_RD:assert property(wr_rd_assert);

property addr_wdata;
	@(posedge clk_i)wr_rd_en_i==1 |-> !($isunknown(addr_i)) ##0 !($isunknown(wdata_i));
endproperty
WDATA:assert property(addr_wdata);

property addr_rdata;
	@(posedge clk_i)wr_rd_en_i==0 |-> !($isunknown(addr_i))##1 !($isunknown(rdata_o));
endproperty
RDATA:assert property(addr_rdata);

endmodule
