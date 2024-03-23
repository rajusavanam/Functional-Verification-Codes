/* Testbench file for Memory Project
 -> Testbench is developed in 3 different model
 	>> Normal Method 
	>> Using Tasks
	>> Backdoor Access method
*/

`timescale 1ns/1ps
`include "memory_design.v"
module memory_tb;

parameter WIDTH=4;
parameter DEPTH=16;
parameter ADDRESS_WIDTH=$clog2(DEPTH);

reg clk_i,rst_i,wr_rd_en_i,valid_i;
reg [ADDRESS_WIDTH-1:0]addr_i;
reg [WIDTH-1:0]wdata_i;
wire ready_o;
wire [WIDTH-1:0]rdata_o;

integer i;

memory_design #(.MEMORY_DEPTH(DEPTH),.MEMORY_WIDTH(WIDTH),.ADDRESS_WIDTH(ADDRESS_WIDTH)) dut(.*);

always begin
	#5 clk_i=0;
	#5 clk_i=1;
end

initial begin
	rst_i=1; // Initialise reset =1, all the enable signals will be initialised to 0;
	wdata_i=0;
	addr_i=0;
	wr_rd_en_i=0;
	valid_i=0;
	#20;
	rst_i=0;
	// For loop to write data into memory
	for(i=0;i<=DEPTH;i=i+1)begin
		@(posedge clk_i) // Data will be written on at posedge of clock. If this signal is not written, the execution of for loop is done at every timestep whether it is positive or negative
		wdata_i=$random; // Generate data randomly to be writen in memory location
		addr_i=i; // Address location of memory where the data is tobe written
		wr_rd_en_i=1; // To write operation
		valid_i=1; // To start Handshaking
		wait(ready_o==1); //At the next posedge, Valid == Ready == 1, so here the handshaking is performed
	end
	// Reset again before starting to read data from memory
	// Reset is done bring the starting
		wdata_i=0;
		addr_i=0;
		wr_rd_en_i=0;
		valid_i=0;
	// For loop to read data from memory
	for(i=0;i<=DEPTH;i=i+1)begin
		@(posedge clk_i)
		addr_i=i;
		wr_rd_en_i=0;
		valid_i=1;
		wait(ready_o==1);
	end
	// Reset again after reading is completed
		addr_i=0;
		wr_rd_en_i=0;
		valid_i=0;
end
initial begin
	#500;
	$finish;
end
endmodule
