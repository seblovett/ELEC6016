package opcodes;

// ALU funcitons

typedef enum logic [1:0] {ALU_A = 0, ALU_ADD = 1, ALU_MULT = 2, ALU_NOOP = 3} alu_functions_t;

typedef enum logic [2:0] {
	NOOP  = 0,
	WAIT  = 1,
	STSW  = 2,
	LEDS  = 3,
	PASSA = 4,
	ADD   = 5,
	MULT  = 6,
	STACC = 7
} opcodes_t;


endpackage
