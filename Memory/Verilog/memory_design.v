/* This is a memory project RTL code using verilog language.
 Any memory majorly consists of two tasks writing data into memory and reading the data from the memory.
 Lets go through the major signals/ports required to start the memory project.
 Memory consists of the following input and output ports
    -> Clock - Input
    -> Reset - Input
    -> Address Locations - Input
    -> Write Data Signal - Input
    -> Write/Read Enable Signal - Input
    -> Read Data Signal - Output
    -> Valid Signal - Input
    -> Ready Signal - Output
    "Valid and Ready are Handshaking signals"

    Parameters
        -> WIDTH
        -> DEPTH
        -> ADDRESS_WIDTH= $clog2(DEPTH)
    Internal Signals
        -> Memory_register- reg [WIDTH-1:0]memory[DEPTH-1:0]  */
// RTL

// Module declaration
module memory(clk_i, rst_i, addr_i, wdata_i, rdata_o, wr_rd_i, valid_i, ready_o);

parameter MEMORY_WIDTH;
parameter MEMORY_DEPTH;
parameter ADDRESS_WIDTH=$clog2(MEMORY_DEPTH);

input clk_i, rst_i, wr_rd_i, valid_i;
input [ADDRESS_WIDTH-1:0]addr_i;
input [MEMORY_WIDTH-1:0]wdata_i;
output reg ready_o;
output reg [MEMORY_WIDTH-1:0]rdata_o;

// Internal signals
reg [MEMORY_WIDTH-1:0]mem[MEMORY_DEPTH-1:0];

integer i;

always @(posedge clk_i)begin
    if(rst_i==1)begin
        // When reset is high memory must be cleared
        for(i=0;i<MEMORY_DEPTH;i=i+1)begin
            mem[i]=0;
        end
        ready_o=0;
        rdata_o=0;
    end
    else begin
        // If reset is low, check for handshaking whether data transfer is possible or not
        if(valid_i==1)begin
            ready_o=1;
            if(wr_rd_i==1)begin
                // Write into the memory
                mem[addr_i]=wdata_i;
            end
            else begin
                rdata_o=mem[addr_i];
            end
        end
        else ready_o=0;
    end
end
endmodule 