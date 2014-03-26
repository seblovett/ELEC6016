// control.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:21:44 GMT
// <+Last Edited: Sun 02 Mar 2014 22:28:42 GMT by hl13g10 on hart2.ecs.soton.ac.uk +>


module control (
	input wire  Clock, nReset, 
	//input wire  opcodes::opcodes_t OpCode,
	input opcodes::opcodes_t OpCode,
	input wire  Sw8,
	output logic RegWe, WDataSel, AccStore, Op1Sel, ImmSel, //Op2Sel,
	output opcodes::alu_functions_t AluOp,
	output opcodes::PcSel_t PcSel
	);

timeunit 1ns; timeprecision 1ps;

import opcodes::*;

typedef enum logic [1:0] {Fetch, Read, Execute} state_t;
state_t state;

always_ff @ (posedge Clock or negedge nReset)
begin
	if(!nReset)
		state <= Fetch;
	else
	begin
		case(state)
			Fetch: state <= Read;
			Read:  state <= Execute;
			Execute: state <= Fetch;
		endcase
	end
end

assign AccStore = OpCode[3] & (state == Execute);
assign Op1Sel = OpCode[2] ^ OpCode[3];
assign AluOp = alu_functions_t'({OpCode[1], OpCode[0]});
assign RegWe = !(OpCode[3] | OpCode[2] | OpCode[1]);
assign WDataSel = !(OpCode[1] | OpCode[0]);
assign ImmSel = !(OpCode[0] | OpCode[1]);
always_comb
begin
	//some defaults
	//RegWe = 0;
	//WDataSel = 0;
	PcSel = PcWait;
	//AluOp = ALU_NOOP;
	//AccStore = 0;
	//Op1Sel = 0;
	//Op2Sel = 0;
	//ImmSel = 0;
	if (state == Execute)
	begin
	PcSel = PcInc;
	case(OpCode)
	//NOOP  :	//Use defaults
	WAIT0 :	begin
			if(~Sw8) PcSel = PcWait;
		end
	WAIT1 :	begin
			if(Sw8) PcSel = PcWait;
		end
	JMPA  : begin
			//Op1Sel = 1; //immediate
			PcSel  = PcJmp;
			//AluOp  = ALU_ADD;
		end
		default:
			PcSel = PcInc;
			
	endcase
	end //if
end
endmodule

