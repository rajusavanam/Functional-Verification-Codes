/* Testbench file for Memory Project
 -> Testbench is developed in 3 different model
 	>> Normal Method 
	>> Using Tasks
	>> Backdoor Access method
*/

`timescale 1ns/1ps
`include "memory_design.v"
module memory_tb_testcase;

parameter WIDTH=8;
parameter DEPTH=16;
parameter ADDRESS_WIDTH=$clog2(DEPTH);

reg clk_i,rst_i,wr_rd_en_i,valid_i;
reg [ADDRESS_WIDTH-1:0]addr_i;
reg [WIDTH-1:0]wdata_i;
wire ready_o;
wire [WIDTH-1:0]rdata_o;

integer i,j;
reg [8*50:1]testcase;
reg [ADDRESS_WIDTH-1:0]b[DEPTH-1:0];

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
	$value$plusargs("testcase=%0s",testcase);
	$display("\n\tTestcase= %0s\n",testcase);
	case(testcase)
		"fd_write_fd_read":begin // Frontdoor Write Frontdoor Read
			fd_write_task(0,DEPTH);
			fd_read_task(0,DEPTH);
		end
		"bd_write_bd_read":begin // Backdoor Write Backdoor Read
			bd_write_task(0,DEPTH);
			bd_read_task(DEPTH*2/4,DEPTH/4);
		end
		"fd_write_bd_read":begin // Frontdoor Write Backdoor Read
			fd_write_task(0,DEPTH);
			bd_read_task(0,DEPTH);
		end
		"bd_write_fd_read":begin // Backdoor Write Frontdoor Read
			bd_write_task(0,DEPTH);
			fd_read_task(0,DEPTH);
		end
		"random_write_read":begin // Random Address Write, Random Address Read
			random_write_task(0,DEPTH);
			random_read_task(0,DEPTH);
		end
	endcase
		
end
// Frontdoor Write Task 
task fd_write_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH:0]number_of_locations);
	begin
	// For loop to write data into memory
	for(i=start_adderss;i<=(start_adderss+number_of_locations);i=i+1)begin
		@(posedge clk_i)
		wdata_i=$random; 
		addr_i=i; 
		wr_rd_en_i=1;
		valid_i=1; 
		wait(ready_o==1); 
	end
	// Reset again before starting to read data from memory
	reset_task();
	end
endtask
// Frontdoor Read Task
task fd_read_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH:0]number_of_locations);
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

//Backdoor Write Task
task bd_write_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH:0]number_of_locations);
	begin
		$readmemh("image.hex",dut.mem,start_adderss,start_adderss+number_of_locations-1);
	end
endtask

//Backdoor read Task
task bd_read_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH:0]number_of_locations);
	begin
		$writememb("image_out.bin",dut.mem,start_adderss,start_adderss+number_of_locations-1);
	end
endtask

// Random Adderss Write Task
task random_write_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH:0]number_of_locations);
	begin
	for(i=start_adderss;i<=(start_adderss+number_of_locations);i=i+1)begin
		@(posedge clk_i)
		wdata_i=$random; 
		addr_i=$random;
	        b[i]=addr_i;	
		wr_rd_en_i=1;
		valid_i=1; 
		wait(ready_o==1); 
	end
	// Reset again before starting to read data from memory
	reset_task();
	end
endtask

// Random Adderss Read Task
task random_read_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH:0]number_of_locations);
	begin
	for(i=start_adderss;i<=(start_adderss+number_of_locations);i=i+1)begin
		@(posedge clk_i)
		//addr_i=$random;
		addr_i=b[i];
		//b[i]=addr_i;
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
