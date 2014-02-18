// alu_tb.sv
// Writen by seblovett
// Date Created Mon 17 Feb 2014 09:26:29 GMT
// <+Last Edited: Mon 17 Feb 2014 10:21:00 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module alu_tb ();

timeunit 1ns; timeprecision 1ps;

import opcodes::*;

parameter n = 8;

logic [n:0] a, b, q;
alu_functions_t Function; 

alu #(.n(n)) instance1 (.*);

initial
	$monitor("%0dns \t%d\t%d\t%d",$time,a,b,q);

initial
begin
	$display("ALU Test");
	$display("Time\ta\tb\tq");
	Function = ALU_ADD;
	a = 0;
	b = 0;

	#10
	a = 2;
	b = 27;
	
	#10 
	Function = ALU_MULT;

end

endmodule

