`define MEM_WIDTH 16
`define MEM_DEPTH 64
`define ADDR_WIDTH $clog2(`MEM_DEPTH)

module mem_design(clk_i,rst_i,valid_i,wr_rd_en_i,addr_i,wdata_i,ready_o,rdata_o);

	input clk_i;
	input rst_i;
	input valid_i;
	input wr_rd_en_i;
	input [`ADDR_WIDTH-1:0]addr_i;
	input [`MEM_WIDTH-1:0]wdata_i;
	output reg ready_o;
	output reg [`MEM_WIDTH-1:0]rdata_o;

	reg [`MEM_WIDTH-1:0]memory[`MEM_DEPTH-1:0];

	always@(posedge clk_i)begin
		if(rst_i == 1)begin
			for(int i=0;i<`MEM_DEPTH;i++)begin
				memory[i]=0;
			end
			ready_o=0;
			rdata_o=0;
		end
		else begin
			if(valid_i==1)begin
				ready_o=1;
				if(wr_rd_en_i==1)begin
					memory[addr_i]=wdata_i;
				end
				else begin
					rdata_o = memory[addr_i];
				end
			end
			else ready_o=0;
		end
	end
endmodule
