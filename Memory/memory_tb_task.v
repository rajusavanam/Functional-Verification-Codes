/* Testbench file for Memory Project
 -> Testbench is developed in 3 different model
 	>> Normal Method 
	>> Using Tasks
	>> Backdoor Access method
*/

`timescale 1ns/1ps
`include "memory_design.v"
module memory_tb_task;

parameter WIDTH=4;
parameter DEPTH=16;
parameter ADDRESS_WIDTH=$clog2(DEPTH);

reg clk_i,rst_i,wr_rd_en_i,valid_i;
reg [ADDRESS_WIDTH-1:0]addr_i;
reg [WIDTH-1:0]wdata_i;
wire ready_o;
wire [WIDTH-1:0]rdata_o;

integer i,j;

memory_design #(.MEMORY_DEPTH(DEPTH),.MEMORY_WIDTH(WIDTH),.ADDRESS_WIDTH(ADDRESS_WIDTH)) dut(.*);

always begin
	#5 clk_i=0;
	#5 clk_i=1;
end

task reset_task();
	begin
		wdata_i=0;
		addr_i=0;
		wr_rd_en_i=0;
		valid_i=0;
	end
endtask

initial begin
	rst_i=1; // Initialise reset =1, all the enable signals will be initialised to 0;
	reset_task();	
	#20;
	rst_i=0;
//	write_task(4,6);
//	read_task(4,6);
	for(j=0;j<4;j=j+1)begin
		write_task(j*(DEPTH/4),DEPTH/4);	
		read_task(j*(DEPTH/4),DEPTH/4);
	end	
end
task write_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH:0]number_of_locations);
	begin
	// For loop to write data into memory
	for(i=start_adderss;i<=(start_adderss+number_of_locations);i=i+1)begin
		@(posedge clk_i)
		wdata_i=$random; // Generate data randomly to be writen in memory location
		addr_i=i; // Address location of memory where the data is tobe written
		wr_rd_en_i=1; // To write operation
		valid_i=1; // To start Handshaking
		wait(ready_o==1); //At the next posedge, Valid == Ready == 1, so here the handshaking is performed
	end
	// Reset again before starting to read data from memory
	reset_task();
	end
endtask
task read_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH-1:0]number_of_locations);
	begin
	// For loop to read data from memory
	for(i=start_adderss;i<=(start_adderss+number_of_locations);i=i+1)begin
		@(posedge clk_i)
		addr_i=i;
		wr_rd_en_i=0;
		valid_i=1;
		wait(ready_o==1);
	end
	// Reset again after reading is completed
	reset_task();
	end
endtask
initial begin
	#400;
	$finish;
end
endmodule
