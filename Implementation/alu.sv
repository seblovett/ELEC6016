// alu.sv
// Writen by seblovett
// Date Created Mon 17 Feb 2014 09:18:54 GMT
// <+Last Edited: Mon 17 Feb 2014 09:19:45 GMT by seblovett on seblovett-Ubuntu +>


module alu (
	input logic [7:0] a, b, 
	output logic [7:0] q;


always_comb
 begin
	q = a + b;
 end
endmodule

