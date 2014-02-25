package opcodes;

// ALU funcitons

typedef enum logic [1:0] {ALU_A = 0, ALU_ADD = 1, ALU_MULT = 2, ALU_NOOP = 3} alu_functions_t;

typedef enum logic [3:0] {
	NOOP  = 0,
	WAIT0 = 2,
	WAIT1 = 3,
	STSW  = 4,
	LEDS  = 6,
	PASSA = 8,
	LUI   = 9,
	ADD   = 10,
	ADDI  = 11,
	MULT  = 12,
	STACC = 14
} opcodes_t;


endpackage
