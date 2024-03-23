/* Memory consists of the following input and output ports
 -> Clock - Input
 -> Reset - Input
 -> Address Locations - Input
 -> Write Data Signal - Input
 -> Write/Read Enable Signal - Input
 -> Valid Signal - Input
 -> Read Data Signal - Output
 -> Ready Signal - Output

 Parameters
 -> WIDTH
 -> DEPTH
 -> ADDRESS_WIDTH= $clog2(DEPTH)
 Internal Signals
 -> Memory_register- reg [WIDTH-1:0]memory[DEPTH-1:0]
*/

// Module declaration
module memory_design(clk_i,rst_i,addr_i,wdata_i,wr_rd_en_i,valid_i,rdata_o,ready_o);

// Parameters Declaration
parameter MEMORY_WIDTH;
parameter MEMORY_DEPTH;
parameter ADDRESS_WIDTH=$clog2(MEMORY_DEPTH);

input clk_i,rst_i,wr_rd_en_i,valid_i;
input [ADDRESS_WIDTH-1:0]addr_i;
input [MEMORY_WIDTH-1:0]wdata_i;
output reg ready_o;
output reg [MEMORY_WIDTH-1:0]rdata_o;

reg [MEMORY_WIDTH-1:0]mem[MEMORY_DEPTH-1:0]; // This is        declaration for memory size.
integer i; // Integer used in for loop to iterate through "mem"

always@(posedge clk_i)begin
	if(rst_i==1)begin
		// If reset is 1, initialise all the signals to 0.
		// Memory data is also initialized to 0.
		for(i=0;i<MEMORY_DEPTH;i=i+1)begin
			mem[i]=0;
		end
		ready_o=0;
		rdata_o=0;
	end
	else begin
		// Check if Handshaking is happening. i.e., valid = ready = 1
		if(valid_i==1)begin
			ready_o=1;
			// Check Write/Read Enable signal.
			// If it is 1, do write operation
			// If it is 0, do read operation
			if(wr_rd_en_i==1)begin
				mem[addr_i]=wdata_i; // Write into Memory by storing data into memory address.
			end
			else begin
				rdata_o=mem[addr_i]; // Read from Memory by giving memory address data into the rdata output.
			end
		end
		else ready_o=0;
	end
end
endmodule	
