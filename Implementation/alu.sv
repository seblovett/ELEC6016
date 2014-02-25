// alu.sv
// Writen by seblovett
// Date Created Mon 17 Feb 2014 09:18:54 GMT
// <+Last Edited: Tue 25 Feb 2014 11:54:00 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module alu #(parameter n = 8) //n - data bus width
(
	input logic [n:0] a, b, 
	input opcodes::alu_functions_t Function,
	output logic [n:0] q);

timeunit 1ns; timeprecision 1ps;

import opcodes::*;

always_comb
 begin
	q = 0; //default case
	unique case (Function)
		ALU_A:		q = a;
		ALU_ADD:	q = a + b;
		ALU_MULT:	q = a * b;
		default:	q = 0;
	endcase
	
 end
endmodule

