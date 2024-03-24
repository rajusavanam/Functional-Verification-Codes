`timescale 1ns/1ps
`include "async_fifo_design.v"
module fifo_tb;

parameter DEPTH=16;
parameter WIDTH=4;
parameter ADDRESS_WIDTH=$clog2(DEPTH);

reg wr_clk_i,rd_clk_i,rst_i,wr_en_i,rd_en_i;
reg [WIDTH-1:0]wdata_i;
wire empty_o,full_o,error_o;
wire [WIDTH-1:0]rdata_o;

integer i;
async_fifo_design #(.DEPTH(DEPTH),.WIDTH(WIDTH),.ADDRESS_WIDTH(ADDRESS_WIDTH)) dut(.*);

always begin
	#5 wr_clk_i=0;
	#5 wr_clk_i=1;
end
always begin
	#7 rd_clk_i=0;
	#7 rd_clk_i=1;
end

initial begin
	rst_i=1;
	wr_en_i=0;
	rd_en_i=0;
	wdata_i=0;
	#20;
	rst_i=0;
	for(i=0;i<=DEPTH;i=i+1)begin
		@(posedge wr_clk_i)
		wr_en_i=1;// Everytime while writing, wr_en_i should be active.
		wdata_i=$random;
	end
		wdata_i=0;
		wr_en_i=0;

	for(i=0;i<=DEPTH;i=i+1)begin
		@(posedge rd_clk_i);
		rd_en_i=1;
	end
		rd_en_i=0;
	#20;
	$finish;
end
endmodule
