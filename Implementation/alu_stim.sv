// alu_tb.sv
// Writen by seblovett
// Date Created Mon 17 Feb 2014 09:26:29 GMT
// <+Last Edited: Thu 03 Apr 2014 13:20:26 BST by hl13g10 on hind.ecs.soton.ac.uk +>


module alu_stim ();

timeunit 1ns; timeprecision 1ps;

import opcodes::*;

parameter n = 8;

logic signed [n-1:0] a, b, q;
alu_functions_t Function; 

alu #(.n(n)) instance1 (.*);

initial
	$monitor("%0dns \t%d\t%d\t%d",$time,a,b,q);


int i, errors;
logic [15:0] temp;

initial
begin
	errors = 0;
	$display("ALU Test");
	$display("Time\ta\tb\tq");
	$display("ALU_ADD");
	Function = ALU_ADD;
	i = 0;	
	for ( i = 0; i < 10; i ++)
	begin
		a = $random();
		b = $random();
		#10 assert (q == (a+b)) else begin 
			errors++;
			$display("Addition error!\n a\tb\tq\texpected\n%d\t%d\t%d\t%d", a,b,q,a+b);
		end
	end
	
	$display("ALU_MULT");
	#100 Function = ALU_MULT;
	for ( i = 0; i < 10; i ++)
	begin
		a = $random();
		b = $random();
		temp = a * b;
		#10 assert (q == temp[14:7]) else begin 
			errors++;
			$display("Multiplication error!\n a\tb\tq\texpected\n%d\t%d\t%d\t%d", a,b,q,temp[14:7]);
		end
	end
	
	$display("ALU_A");
	#100 Function = ALU_A; 
	for ( i = 0; i < 10; i ++)
	begin
		a = $random();
		b = $random();
		#10 assert (q == a) else begin 
			errors++;
			$display("Pass through error!\n a\tb\tq\texpected\n%d\t%d\t%d\t%d", a,b,q,a);
		end
	end

	if (errors == 0)
		$display("Simulation PASSED!");
	else
		$display("Simulation FAILED with %d errors", errors);
end

endmodule

