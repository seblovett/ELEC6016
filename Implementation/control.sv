// control.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:21:44 GMT
// <+Last Edited: Tue 25 Feb 2014 18:23:07 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module control (
	input wire  Clock, Reset, 
	input wire  opcodes::opcodes_t OpCode,
	input wire  Sw8,
	output logic RegWe, WDataSel, AccStore, LedStore, Op1Sel, ImmSel, Op2Sel,
	output opcodes::alu_functions_t AluOp,
	output opcodes::PcSel_t PcSel
	);

timeunit 1ns; timeprecision 1ps;

import opcodes::*;


always_comb
begin
	//some defaults
	RegWe = 0;
	WDataSel = 0;
	PcSel = PcInc;
	AluOp = ALU_NOOP;
	AccStore = 0;
	LedStore = 0;
	Op1Sel = 0;
	Op2Sel = 0;
	ImmSel = 0;
	case(OpCode)
	//NOOP  :	//Use defaults
	WAIT0 :	begin
			if(~Sw8) PcSel = PcWait;
		end
	WAIT1 :	begin
			if(Sw8) PcSel = PcWait;
		end
	STSW  :	begin
			WDataSel = 1; //Choose switches
			RegWe    = 1; //Write to Reg
		end
//	LEDS  :		LedStore = 1;
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
			ImmSel = 1; 
		end
	ADDI  : begin
			Op1Sel = 1;
			AluOp = ALU_ADD;
			AccStore = 1;
			//ImmSel = 0; 
		end
	MULT  :	begin
			AluOp = ALU_MULT;
			AccStore = 1;
		end
	STACC :	begin	
			//WDataSel = 0; // choose the ACC
			RegWe = 1;
		end
	JMP   : begin
			Op1Sel = 1; //imedaite
			Op2Sel = 1; //PC
			PcSel  = PcJmp;
			AluOp  = ALU_ADD;
		end
	endcase

end
endmodule

