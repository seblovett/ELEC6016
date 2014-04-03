// datapath_stim.sv
// Writen by seblovett
// Date Created Thu 03 Apr 2014 15:42:21 BST
// <+Last Edited: Thu 03 Apr 2014 16:29:52 BST by hl13g10 on hind.ecs.soton.ac.uk +>


module datapath_stim ();

timeunit 1ns; timeprecision 1ps;

import opcodes::*;

parameter n = 8;
parameter pc_n = 5;

logic [n-1:0] MemData, Switches;
wire [pc_n-1:0] Pc;
logic [n-1 : 0] LEDs;
logic  Clock, nReset, RegWe, ImmSel, WDataSel, AccWe, Op1Sel, PcWe;
opcodes::alu_functions_t AluOp;
opcodes::PcSel_t PcSel;

datapath d (.*);

int errors;

//clock
always
begin
        Clock = 0;
        #250 Clock = 1;
        #500 Clock = 0;
        #250 Clock = 0;
end

//reset
initial
begin
        nReset = 1;
        #100 nReset = 0;
        #1000 nReset = 1;
end

initial
begin
	errors = 0;
	RegWe = 0;
	ImmSel = 0;
	WDataSel = 0;
	AccWe = 0;
	Op1Sel = 0;
	PcWe = 0;
	AluOp = ALU_A;
	PcSel = PcInc;
	MemData = 0;
	Switches = 0;

	//Test PC increments
	@ (posedge Clock)
	#20 PcWe = 1;
	@ (posedge Clock)
	#20 assert(1 == Pc) else begin errors++; $display("PcInc error"); end
	@ (posedge Clock)
	#20 assert(2 == Pc) else begin errors++; $display("PcInc error"); end
	@ (posedge Clock)
	#20 assert(3 == Pc) else begin errors++; $display("PcInc error"); end
	PcWe = 0;
	@ (posedge Clock)
	#20 assert(3 == Pc) else begin errors++; $display("PcInc error"); end
	
	//Test Imm loading into ACC (high and low)
	//Low 
	MemData = 8'h55;
	ImmSel = 0;
	Op1Sel = 1;
	AluOp = ALU_A;
	AccWe = 1;
	@ (posedge Clock)
	#20 assert ( 8'h05 == LEDs) else begin errors++; $display("Imm Store Low error"); end
	ImmSel = 1;
	@ (posedge Clock)
	#20 assert ( 8'h50 == LEDs) else begin errors++; $display("Imm Store Low error"); end
	
	//Addition with imm value
	ImmSel = 0;
	AluOp = ALU_ADD;
	@ (posedge Clock)
	#20 assert ( 8'h55 == LEDs) else begin errors++; $display("Imm Store Low error"); end
	AccWe = 0;
	//Writeback to register
	MemData = 0; //write to reg 0;
	RegWe = 1;
	AluOp = ALU_A;
	@ (posedge Clock)
	#20 RegWe = 0;
	//Read from Register
	Op1Sel = 0;
	@ (posedge Clock)
	#20 AccWe = 1; 
	@ (posedge Clock)
	#20 assert ( 8'h55 == LEDs ) else begin errors++; $display("Reg store/read error"); end
	AccWe = 0;
	
	//Store swtiches to reg
	Switches = 8'hAA;
	MemData = 8'h01;
	RegWe = 1;
	WDataSel = 1;
	@ (posedge Clock)
	#20 RegWe = 0;
	WDataSel = 0;
	
	@ (posedge Clock)
	#20 AccWe = 1;
	@ (posedge Clock)
	#20 assert ( Switches == LEDs) else begin errors++; $display("Switch store error"); end
	AccWe = 0;

	//Test Jmp
	PcSel = PcJmp; 
	PcWe = 1;
	@ (posedge Clock)
	#20 assert ( Switches[pc_n -1:0] == Pc ) else begin errors++; $display("PcJmp error"); end
	PcWe = 0;

	if (errors == 0)
		$display("Simulation PASSED");	
	else 
		$display("Simulation FAILED with %d errors", errors);
	#4000 $stop();
end

endmodule

