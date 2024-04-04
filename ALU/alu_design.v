// ALU RTL File
// Lets do arithmetic operations such as ADDITION, SUBTRACTION, MULTIPLY, AND, OR, XOR etc
// 
module alu_design(clk_i,rst_i,valid_i,ready_o,operand_a,operand_b,operation,result);

	input clk_i,rst_i,valid_i;
	input [31:0]operand_a,operand_b;
	input [2:0]operation;
	output reg ready_o;
	output reg [31:0]result;

	//function reg [31:0]result(input reg[31:0]operand_a,operand_b, input reg [2:0]operation);
	always@(posedge clk_i) begin
		if(rst_i==1)begin
			ready_o=0;
			result=0;
		end
		else begin
			if(valid_i==1)begin
				ready_o=1;
				case(operation)
					3'b000: result = operand_a + operand_b; //ADDITION
					3'b001: result = operand_a - operand_b; //SUBTRACTION
					3'b010: result = operand_a * operand_b; //MULTIPLICATION
					3'b011: result = operand_a / operand_b; //DIVISION
					3'b100: result = operand_a % operand_b; //REMAINDER
					3'b101: result = operand_a & operand_b; //AND
					3'b110: result = operand_a | operand_b; //OR
					3'b111: result = operand_a ^ operand_b; //XOR
				endcase
			end
			else ready_o=0;
		end
	end
endmodule
