// control.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:21:44 GMT
// <+Last Edited: Tue 25 Feb 2014 11:51:17 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module control (
	input wire  Clock, Reset, 
	input wire  opcodes::opcodes_t OpCode,
	input wire  Cond,
	output logic RegWe, WDataSel, PcWait,
	output opcodes::alu_functions_t AluOp
	);

timeunit 1ns; timeprecision 1ps;

import opcodes::*;

assign AluOp = ALU_ADD;
assign RegWe = 0;
assign WDataSel = 0;
assign PcWait = 0;
endmodule

