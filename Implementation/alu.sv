// alu.sv
// Writen by seblovett
// Date Created Mon 17 Feb 2014 09:18:54 GMT
// <+Last Edited: Wed 02 Apr 2014 20:49:18 BST by seblovett on seblovett-Ubuntu +>


module alu #(parameter n = 8) //n - data bus width
(
	input logic signed [n-1:0] a, b, 
	input opcodes::alu_functions_t Function,
	output logic signed [n-1:0] q);

timeunit 1ns; timeprecision 1ps;

import opcodes::*;

logic signed [2*n - 1 : 0] multout;
assign multout = a*b;

always_comb
 begin
	//q = 0; //default case
	unique case (Function)
		ALU_A:		q = a;
		ALU_ADD:	q = a + b;
		ALU_MULT:	q = multout[14:7];
		default:	q = a;
	endcase
	
 end
endmodule

