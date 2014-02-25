// control.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:21:44 GMT
// <+Last Edited: Tue 25 Feb 2014 17:02:59 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module control (
	input wire  Clock, Reset, 
	input wire  opcodes::opcodes_t OpCode,
	input wire  Sw8,
	output logic RegWe, WDataSel, PcWait, AccStore, LedStore, Op1Sel,
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
	AccStore = 0;
	LedStore = 0;
	Op1Sel = 0;
	case(OpCode)
	//NOOP  :	//Use defaults
	WAIT0 :	begin
			PcWait = ~Sw8;	
		end
	WAIT1 :	begin
			PcWait = Sw8;	
		end
	STSW  :	begin
			WDataSel = 1; //Choose switches
			RegWe    = 1; //Write to Reg
		end
	LEDS  :		LedStore = 1;
	PASSA :	begin
			AluOp =  ALU_A; //set alu op
			AccStore = 1;   //store to acc
		end
	ADD   :	begin
			AluOp = ALU_ADD;
			AccStore = 1;
		end
	LUI   : begin
			Op1Sel = 1; //choose immediate
			AluOp = ALU_A; //pass through
			AccStore = 1;
		end
	MULT  :	begin
			AluOp = ALU_MULT;
			AccStore = 1;
		end
	STACC :	begin	
			//WDataSel = 0; // choose the ACC
			RegWe = 1;
		end
	endcase

end
endmodule

