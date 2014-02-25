// control.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:21:44 GMT
// <+Last Edited: Tue 25 Feb 2014 12:18:39 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module control (
	input wire  Clock, Reset, 
	input wire  opcodes::opcodes_t OpCode,
	input wire  Cond,
	output logic RegWe, WDataSel, PcWait,
	output opcodes::alu_functions_t AluOp
	);

timeunit 1ns; timeprecision 1ps;

import opcodes::*;


always_comb
begin
	//some defaults
	RegWe = 0;
	WDataSel = 0;
	PcWait = 0;
	AluOp = ALU_NOOP;
	
	case(OpCode)
	//NOOP  :	//Use defaults
//	WAIT  :	
	STSW  :	begin
			WDataSel = 1; //Choose switches
			RegWe    = 1; //Write to Reg
		end
//	LEDS  :	
//	PASSA :	
//	ADD   :	
//	MULT  :	
//	STACC :	
	endcase

end
endmodule

