module async_fifo_gray(wr_clk_i,rd_clk_i,rst_i,wr_en_i,rd_en_i,wdata_i,rdata_o,wr_error_o,rd_error_o,empty_o,full_o);

parameter WIDTH=16;
parameter DEPTH=16;
parameter PTR_WIDTH=$clog2(DEPTH);

input wr_clk_i,rd_clk_i,rst_i;
input wr_en_i,rd_en_i;
input [WIDTH-1:0]wdata_i;

output reg [WIDTH-1:0]rdata_o;
output reg wr_error_o,rd_error_o;
output reg empty_o,full_o;

reg [WIDTH-1:0] mem [DEPTH-1:0];

reg [PTR_WIDTH-1:0]wr_ptr,rd_ptr;
reg wr_toggle_f,rd_toggle_f;
//reg [PTR_WIDTH-1:0]wr_ptr_rd_clk,rd_ptr_wr_clk;
reg wr_toggle_f_rd_clk,rd_toggle_f_wr_clk;
reg [PTR_WIDTH-1:0]wr_ptr_gray,rd_ptr_gray;
reg [PTR_WIDTH-1:0]wr_ptr_rd_clk_gray,rd_ptr_wr_clk_gray;
integer i;

//		---------> Process - 1 <------------
//Logic for Write and Read FIFO

always@(posedge wr_clk_i)begin
	if(rst_i==1)begin	// If reset is applied --> Making all regesters to zero
		rdata_o=0;
		wr_error_o=0;
		rd_error_o=0;
		empty_o=1; //indicating that FIFO is empty
		full_o=0;
		wr_ptr=0;
		rd_ptr=0;
		wr_toggle_f=0;
		rd_toggle_f=0;
//		wr_ptr_rd_clk=0;
//		rd_ptr_wr_clk=0; 
		wr_toggle_f_rd_clk=0;
		rd_toggle_f_wr_clk=0;
		wr_ptr_gray=0;
		rd_ptr_gray=0;
		wr_ptr_rd_clk_gray=0;
		rd_ptr_wr_clk_gray=0;
		for(i=0;i<DEPTH;i=i+1) mem[i]=0;
	end
	else begin
		//Write Logic of FIFO
		wr_error_o=0; // Helps to get restrict the error for one clock cycle at the end
		
		// If Write Enable is High, then we need to check for full and if not full then we can write data to FIFO.
		
		if(wr_en_i==1)begin 
			if(full_o==1)begin //If FIFO is full
				wr_error_o=1; // IF FIFO is full and we are writing to FIFO, so it makes, write error pin to High
			end
			else begin // If FIFO is not Full
				mem[wr_ptr]=wdata_i; // Writing the DATA to FIFO
				if(wr_ptr==DEPTH-1) begin // If wr_ptr value = DEPTH-1 then, automatically , wr_ptr will roll back to 0, so for that wr_toggle_f, need to be toggle, saying that rolling of wr_ptr occur.
					wr_toggle_f=~wr_toggle_f; // Toggle wr_toggle_f, helps us to understand that wr_ptr rolled back.
				end
				wr_ptr=wr_ptr+1; //Incrementing the write pointer.
				wr_ptr_gray={wr_ptr[3],wr_ptr[3:1] ^ wr_ptr[2:0]};
			end
		end
	end
end

//		--------> Process - 2 <------------
always@(posedge rd_clk_i)begin
//At reset is low, If Read Enable is High, then we need to check for empty and if not empty, then we can read data to FIFO.
		//Read from FIFO
	rd_error_o=0; // Helps to get restrict the error for one clock cycle at the end
	if(rst_i!=1)begin
		if(rd_en_i==1)begin // if Read Enable is High
			if(empty_o==1)begin // If FIFO is Empty
				rd_error_o=1;// IF FIFO is  Empty and we are reading from FIFO, so it makes, read error pin to High
 
			end
			else begin// If FIFO is not Empty
				rdata_o=mem[rd_ptr];// Reading DATA from FIFO 
				if(rd_ptr==DEPTH-1)begin// If wr_ptr value = DEPTH-1 then, automatically , wr_ptr will roll back to 0, so for that wr_toggle_f, need to be toggle, saying that rolling of wr_ptr occur. 
					rd_toggle_f=~rd_toggle_f;// Toggle wr_toggle_f, helps us to understand that wr_ptr rolled back. 
				end
				rd_ptr=rd_ptr+1;//Incrementing the write pointer.
				rd_ptr_gray={rd_ptr[3],rd_ptr[3:1] ^ rd_ptr[2:0]};
			end
		end
	end
end

// ------------> Process - 3 <-------------
// Logic for Synchronizaton with wr_clk_i

always@(posedge wr_clk_i)begin
	rd_ptr_wr_clk_gray <= rd_ptr_gray; // we are synchronizing the rd_ptr of rd_clk with rd_ptr_wr_clk, which helps to get the rd_ptr for full logic.
	rd_toggle_f_wr_clk <= rd_toggle_f; // we are synchronizing the rd_toggle_f of rd_clk with rd_toggle_f_wr_clk , which helps to get the rd_toggle_f for full logic
end

// ------------> Process - 4 <-------------
// Logic for Synchronizaton with rd_clk_i

always@(posedge rd_clk_i)begin
	wr_ptr_rd_clk_gray <= wr_ptr_gray; // we are synchronizing the wr_ptr of wr_clk with wr_ptr_rd_clk, which helps to get the wr_ptr for empty logic.
 
	wr_toggle_f_rd_clk <= wr_toggle_f;// we are synchronizing the wr_toggle_f of wr_clk with wr_toggle_f_rd_clk , which helps to get the wr_toggle_f for empty logic
 
end

//			----------> Process - 5 <---------------
//	Logic for Empty and Full Generation
always@(*)begin
//always@(wr_ptr_gray or rd_ptr_gray or wr_ptr_rd_clk_gray or rd_ptr_wr_clk_gray or wr_toggle_f or rd_toggle_f or wr_toggle_f_rd_clk or rd_toggle_f_wr_clk)begin
	empty_o=0;
	full_o=0;
	if(wr_ptr_gray==rd_ptr_wr_clk_gray)begin
		if(wr_toggle_f!=rd_toggle_f_wr_clk) full_o=1;
	end
	if(rd_ptr_gray==wr_ptr_rd_clk_gray)begin
		if(rd_toggle_f==wr_toggle_f_rd_clk) empty_o=1;
	end
end
endmodule
