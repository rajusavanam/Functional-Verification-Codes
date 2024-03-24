// FIFO- First In First Out
// Synchronous FIFO
// Inputs	
// 	Clock- Input
//	Reset- Input -0/1
//	Write Enable Signal- Input -0/1
//	Read Enable Signal- Input -0/1
//	Write Data- Input -[WIDTH-1:0]
// Outputs
//	Empty Signal- Output -0/1
//	Full Signal- Output -0/1
//	Error Signal- Output -0/1
//	Read Data- Output -[WIDTH-1:0]
// Internal Signals
// 	Write Address Pointer- reg -[ADDRESS_WIDTH-1:0]
// 	Read Address Pointer- reg -[ADDRESS_WIDTH-1:0]
// 	Write Toggle Flag- reg -0/1
// 	Read Toggle Flag- reg -0/1
// 	FIFO MEMORY- reg -[WIDTH-1:0]fifo[DEPTH-1:0]
//
// Operation:
// 	WRITE- When write enable signal is 1 and check whether fifo_memory is empty or not full i.e.,(Full=0 or Empty=1)
// 	READ- When read enable signal is 1 and check whether fifo_memory is full or not empty i.e.,(Empty=0 or Full=1)
//
// Also Check the toggle signals
// 	Empty=1 When Write Pointer == Read Pointer and Write Toggle Flag == Read Toggle Flag
// 	Full=1 When Write Pointer == Read Pointer and Write Toggle Flag != Read Toggle Flag
//
module sync_fifo_design(clk_i,rst_i,wdata_i,wr_en_i,rd_en_i,rdata_o,empty_o,full_o,error_o);

parameter DEPTH=16;
parameter WIDTH=4;
parameter ADDRESS_WIDTH=$clog2(DEPTH);

input clk_i,rst_i,wr_en_i,rd_en_i;
input [WIDTH-1:0]wdata_i;
output reg empty_o,full_o,error_o;
output reg [WIDTH-1:0]rdata_o;

reg [ADDRESS_WIDTH-1:0]wr_ptr,rd_ptr;
reg wr_toggle_flag, rd_toggle_flag;
reg [WIDTH-1:0]fifo[DEPTH-1:0];

integer i;

always@(posedge clk_i)begin
	if(rst_i==1)begin
		empty_o=1;
		full_o=0;
		error_o=0;
		rdata_o=0;
		wr_ptr=0;
		rd_ptr=0;
		wr_toggle_flag=0;
		rd_toggle_flag=0;
		for (i=0;i<DEPTH;i=i+1)begin
			fifo[i]=0;
		end
	end
	else begin
		// Write logic
		if(wr_en_i==1)begin
			if(full_o==0)begin
				error_o=0;
				fifo[wr_ptr]=wdata_i;
				if(wr_ptr==DEPTH-1)begin
					wr_ptr=0;
					wr_toggle_flag=~wr_toggle_flag;
				end
				else begin
					wr_ptr=wr_ptr+1;
				end
			end
			else begin
				error_o=1;
			end
		end
		
		// Read Logic
		if(rd_en_i==1)begin
			if(empty_o==0)begin
				error_o=0;
				rdata_o=fifo[rd_ptr];
				if(rd_ptr==DEPTH-1)begin
					rd_ptr=0;
					rd_toggle_flag=~rd_toggle_flag;
				end
				else begin
					rd_ptr=rd_ptr+1;
				end
			end
			else begin
				error_o=1;
			end
		end
	end
end
always@(*)begin
	full_o=0;
	empty_o=0;
	if(wr_ptr==rd_ptr && wr_toggle_flag==rd_toggle_flag)begin
		empty_o=1;
	end
	if(wr_ptr==rd_ptr && wr_toggle_flag!=rd_toggle_flag)begin
		full_o=1;
	end
end

endmodule
