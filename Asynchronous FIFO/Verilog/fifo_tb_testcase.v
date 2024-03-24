`include "async_fifo_design.v"
module fifo_tb_testcase;

parameter DEPTH=16;
parameter WIDTH=4;
parameter ADDRESS_WIDTH=$clog2(DEPTH);

reg wr_clk_i,rd_clk_i,rst_i,wr_en_i,rd_en_i;
reg [WIDTH-1:0]wdata_i;
wire empty_o,full_o,error_o;
wire [WIDTH-1:0]rdata_o;

integer i,j;
reg [8*50:1]testcase;
async_fifo_design #(.DEPTH(DEPTH),.WIDTH(WIDTH),.ADDRESS_WIDTH(ADDRESS_WIDTH)) dut(.*);

always begin
	#5 wr_clk_i=0;
	#5 wr_clk_i=1;
end
always begin
	#7 rd_clk_i=0;
	#7 rd_clk_i=1;
end

// Reset Task
task reset_task();
	begin
		wr_en_i=0;
		rd_en_i=0;
		wdata_i=0;
	end
endtask

// Write Task
task write_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH:0]number_of_locations);
	begin
		for(i=start_adderss;i<=start_adderss+number_of_locations;i=i+1)begin
			@(posedge wr_clk_i)
			wr_en_i=1;
			wdata_i=$random;
		end
		reset_task();
	end
endtask

// Read Task
task read_task(input [ADDRESS_WIDTH-1:0]start_adderss,[ADDRESS_WIDTH:0]number_of_locations);
	begin
		for(i=start_adderss;i<=start_adderss+number_of_locations;i=i+1)begin
			@(posedge rd_clk_i);
			rd_en_i=1;
		end
		reset_task();
	end
endtask
initial begin
	rst_i=1;
	reset_task();
	#20;
	rst_i=0;
	$value$plusargs("testcase=%0s",testcase);
	$display("\n\tTestcase= %0s\n",testcase);
	case(testcase)
		"wr_rd_all":begin
			// Write into all locations of FIFO
			write_task(0,DEPTH);
			// Read from all location of FIFO
			read_task(0,DEPTH);
		end
		"full_error":begin
			// Full error occurs when we try to write into fifo without reading and writing again.
			write_task(0,DEPTH+3);
			//write_task(0,DEPTH);
		end
		"empty_error":begin
			write_task(0,DEPTH);
			read_task(0,DEPTH+3);
		end
		"wr_rd_concurrent":begin
			// Concurrent write and read means both write and read should happen at same time. This can be acheived by using Fork Join.
			fork
				begin
					for(j=0;j<50;j=j+1)begin
						write_task(0,2);
						#7;
					end
				end
				begin
					for(j=0;j<50;j=j+1)begin
						read_task(0,2);
						#7;
					end
				end
			join
		end
	endcase
	 #10 $finish;
end
endmodule
