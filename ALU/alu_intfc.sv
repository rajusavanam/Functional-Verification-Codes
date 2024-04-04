interface alu_intfc(input logic clk_i,rst_i);
	logic valid_i;
	logic [31:0]operand_a;
	logic [31:0]operand_b;
	logic [2:0]operation;
	logic ready_o;
	logic [31:0]result;

	// Clocking blocks
	clocking drv_cb@(posedge clk_i);
		default input #0 output #1;
		input ready_o;
		input result;
		output valid_i;
		output operand_a;
		output operand_b;
		output operation;
	endclocking

	clocking mon_cb@(posedge clk_i);
		default input #1;
		input ready_o;
		input result;
		input valid_i;
		input operand_a;
		input operand_b;
		input operation;
	endclocking

	// Assertions
	property handshake(valid_i,ready_o);
		@(posedge clk_i) valid_i ==1 |-> ##1 ready_o==1;
	endproperty
	property add_operation(operand_a,operand_b,operation);
		@(posedge clk_i) (operation==0) |=> (result== operand_a+operand_b);
	endproperty

	property sub_operation(operand_a,operand_b,operation);
		@(posedge clk_i) (operation==1) |=> (result== operand_a-operand_b);
	endproperty
	property mul_operation(operand_a,operand_b,operation);
		@(posedge clk_i) (operation==2) |=> (result== operand_a*operand_b);
	endproperty
	property div_operation(operand_a,operand_b,operation);
		@(posedge clk_i) (operation==3) |=> (result== operand_a/operand_b);
	endproperty
	property rem_operation(operand_a,operand_b,operation);
		@(posedge clk_i) (operation==4) |=> (result== operand_a%operand_b);
	endproperty
	property and_operation(operand_a,operand_b,operation);
		@(posedge clk_i) (operation==5) |=> (result== operand_a&operand_b);
	endproperty
	property or_operation(operand_a,operand_b,operation);
		@(posedge clk_i) (operation==6) |=> (result== operand_a|operand_b);
	endproperty
	property xor_operation(operand_a,operand_b,operation);
		@(posedge clk_i) (operation==7) |=> (result== operand_a^operand_b);
	endproperty

	HANDSHAKE:assert property(handshake(valid_i,ready_o));
	ADD_OPE:assert property(add_operation(operand_a,operand_b,operation));
	SUB_OPE:assert property(sub_operation(operand_a,operand_b,operation));
	MUL_OPE:assert property(mul_operation(operand_a,operand_b,operation));
	DIV_OPE:assert property(div_operation(operand_a,operand_b,operation));
	REM_OPE:assert property(rem_operation(operand_a,operand_b,operation));
	AND_OPE:assert property(and_operation(operand_a,operand_b,operation));
	OR_OPE:assert property(or_operation(operand_a,operand_b,operation));
	XOR_OPE:assert property(xor_operation(operand_a,operand_b,operation));
endinterface
