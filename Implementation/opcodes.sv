package opcodes;

// ALU funcitons


typedef enum logic [1:0] {ALU_A = 2'd0, ALU_ADD = 2'd1, ALU_MULT = 2'd3, ALU_NOOP = 2'd2} alu_functions_t;
typedef enum logic  {PcInc = 1'd0, PcJmp = 1'd1} PcSel_t;
typedef enum logic [3:0] {
//	NOOP  = 4'd0,
	STSW  = 4'd0,
	STACC = 4'd1,
	WAIT0 = 4'd3,
	JMPA  = 4'd5,
	WAIT1 = 4'd7,
	LUI   = 4'd8,
	ADDI  = 4'd9,
	PASSA = 4'd12,
	ADD   = 4'd13,
	MULT  = 4'd15
	//JMP   = 4'd5,
//	JMPI  = 4'd7,
} opcodes_t;

endpackage
