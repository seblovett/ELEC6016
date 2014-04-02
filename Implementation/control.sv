// control.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:21:44 GMT
// <+Last Edited: Wed 02 Apr 2014 17:27:24 BST by hl13g10 on octopus +>


module control (
	input wire  Clock, nReset, 
	//input wire  opcodes::opcodes_t OpCode,
	input opcodes::opcodes_t OpCode,
	input wire  Sw8,
	output logic RegWe, WDataSel, AccWe, Op1Sel, ImmSel, PcWe,//Op2Sel,
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
logic [3:0] Op;
assign Op = OpCode;
//The below lines are a listing in the report, do not move
assign AluOp = alu_functions_t'({Op[1], Op[0]});
assign WDataSel = ~(Op[0] | Op[1]);
assign Op1Sel = ((Op[2]) ^ (Op[3]));
assign ImmSel = ~(Op[0] | Op[1]);
assign PcSel = (OpCode == JMPA) ? PcJmp : PcInc;
always_comb 
begin
	AccWe = 1'b0;
	RegWe = 1'b0;
	if (state == Execute) 
	begin
		AccWe = Op[3];
		RegWe =  ~(Op[3] | Op[2] | Op[1]);
	end
end
//end of listing

always_comb
begin
//	PcSel = PcInc;
	PcWe = 0;
	
	if (state == Execute)
	begin
		PcWe = 1;
		case(OpCode)
		WAIT0 :	begin
				if(~Sw8) PcWe = 0;
			end
		WAIT1 :	begin
				if(Sw8) PcWe = 0;
			end
		JMPA  : begin
//				PcSel  = PcJmp;
			end
	//	default:
//				PcSel = PcInc;
		endcase
	end //if
end
endmodule

