// registers.sv
// Writen by seblovett
// Date Created Mon 17 Feb 2014 10:16:30 GMT
// <+Last Edited: Tue 25 Feb 2014 11:39:06 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module registers #(parameter n = 8, parameter addr_width = 5, parameter regcount = 10) ( //n - data bus width, addr_width - width of the address bus, regcount - number of registers
	input wire  Clock, Reset, WE,  //control signals
	output logic [n-1:0] Rd1, //output data
	input wire  [addr_width - 1 :0] Rs1,//input addresses
	input wire  [n-1:0] Data //input data
);

timeunit 1ns; timeprecision 1ps;

logic [n-1:0] regs[regcount-1:0];

always_ff @ (posedge Clock or posedge Reset)
begin
	if(Reset) //Reset the system
		regs <= '{regcount{'{n{0}}}};
	else
	 begin
		if (WE)
			regs[Rs1] <= Data;
	 end
end

assign Rd1 = regs[Rs1];
//assign Rd2 = regs[Rs2];

endmodule
