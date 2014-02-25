package opcodes;

// ALU funcitons

typedef enum logic [1:0] {ALU_A = 2'd0, ALU_ADD = 2'd1, ALU_MULT = 2'd2, ALU_NOOP = 2'd3} alu_functions_t;
typedef enum logic [1:0] {PcWait = 2'd2, PcInc = 2'd0, PcJmp = 2'd1} PcSel_t;
typedef enum logic [3:0] {
	NOOP  = 4'd0,
	WAIT0 = 4'd2,
	WAIT1 = 4'd3,
	STSW  = 4'd4,
	//JMP   = 4'd5,
	JMPA  = 4'd6,
	JMPI  = 4'd7,
	PASSA = 4'd8,
	LUI   = 4'd9,
	ADD   = 4'd10,
	ADDI  = 4'd11,
	MULT  = 4'd12,
	STACC = 4'd14
} opcodes_t;


endpackage
