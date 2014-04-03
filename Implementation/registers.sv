// registers.sv
// Writen by seblovett
// Date Created Mon 17 Feb 2014 10:16:30 GMT
// <+Last Edited: Thu 03 Apr 2014 13:46:27 BST by hl13g10 on hind.ecs.soton.ac.uk +>


module registers #(parameter n = 8, parameter addr_width = 5, parameter regcount = 10) ( //n - data bus width, addr_width - width of the address bus, regcount - number of registers
	input wire  Clock, WE,  //control signals
	output logic [n-1:0] Rd1, //output data
	input wire  [addr_width - 1 :0] Rs1,//input addresses
	input wire  [n-1:0] Data //input data
);

timeunit 1ns; timeprecision 1ps;

logic [n-1:0] regs[regcount-1:0];

always_ff @ (posedge Clock)// or posedge Reset)
begin
		if (WE == 1)
			regs[Rs1] <= Data;
		Rd1 <= regs[Rs1];
end

endmodule
