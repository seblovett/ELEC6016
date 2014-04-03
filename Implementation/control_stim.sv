// control_stim.sv
// Writen by seblovett
// Date Created Thu 03 Apr 2014 13:52:34 BST
// <+Last Edited: Thu 03 Apr 2014 14:33:19 BST by hl13g10 on hind.ecs.soton.ac.uk +>


module control_stim ();

timeunit 1ns; timeprecision 1ps;

import opcodes::*;

logic  Clock, nReset, Sw8;
opcodes_t OpCode;
wire RegWe, WDataSel, AccWe, Op1Sel, ImmSel, PcWe;
alu_functions_t AluOp;
PcSel_t PcSel;

control c (.*);

//clock
always
begin
        Clock = 0;
        #250 Clock = 1;
        #500 Clock = 0;
        #250 Clock = 0;
end

//Reset pulse
initial
begin
	nReset = 1;
	#100 nReset = 0;
	#100 nReset = 1;
end

int errors;
//main test routine
initial
begin
	Sw8 = 0;
	errors = 0;
	OpCode = STSW;
	@ ( posedge Clock)
	while(c.state != c.Execute)
		#1000;
	assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(1 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(1 == WDataSel) else begin errors++; $display("WDataSel Error"); end
	assert(0 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcInc) else begin errors++; $display("PcSel Error"); end

	#20 OpCode = STACC;
	while(c.state != c.Execute)
		#1000;
	assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(1 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(0 == WDataSel) else begin errors++; $display("WDataSel Error"); end
	assert(0 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcInc) else begin errors++; $display("PcSel Error"); end
	
	@ (posedge Clock)
	#20 OpCode = WAIT0;
	while(c.state != c.Execute)
		#1000;
	assert(0 == PcWe) else begin errors++; $display("PcWe Error"); end
	Sw8 = 1;	
	#20 assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(0 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(0 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcInc) else begin errors++; $display("PcSel Error"); end
	
	@ (posedge Clock)
	#20 OpCode = WAIT1;
	while(c.state != c.Execute)
		#1000;
	assert(0 == PcWe) else begin errors++; $display("PcWe Error"); end
	Sw8 = 0;	
	#20 assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(0 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(0 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcInc) else begin errors++; $display("PcSel Error"); end

	
	@ (posedge Clock)
	#20 OpCode = JMPA;
	while(c.state != c.Execute)
		#1000;
	#20 assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(0 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(0 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcJmp) else begin errors++; $display("PcSel Error"); end
	assert(0 == ImmSel) else begin errors++; $display("ImmSel Error"); end	
	assert(1 == Op1Sel) else begin errors++; $display("Op1Sel Error"); end	
	assert(ALU_ADD == AluOp) else begin errors++; $display("AluOp Error"); end
	
	@ (posedge Clock)
	#20 OpCode = LUI;
	while(c.state != c.Execute)
		#1000;
	#20 assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(0 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(1 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcInc) else begin errors++; $display("PcSel Error"); end
	assert(1 == ImmSel) else begin errors++; $display("ImmSel Error"); end	
	assert(1 == Op1Sel) else begin errors++; $display("Op1Sel Error"); end	
	assert(ALU_A == AluOp) else begin errors++; $display("AluOp Error"); end

	@ (posedge Clock)
	#20 OpCode = ADDI;
	while(c.state != c.Execute)
		#1000;
	#20 assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(0 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(1 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcInc) else begin errors++; $display("PcSel Error"); end
	assert(0 == ImmSel) else begin errors++; $display("ImmSel Error"); end	
	assert(1 == Op1Sel) else begin errors++; $display("Op1Sel Error"); end	
	assert(ALU_ADD == AluOp) else begin errors++; $display("AluOp Error"); end


	@ (posedge Clock)
	#20 OpCode = PASSA;
	while(c.state != c.Execute)
		#1000;
	#20 assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(0 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(1 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcInc) else begin errors++; $display("PcSel Error"); end
	assert(0 == Op1Sel) else begin errors++; $display("Op1Sel Error"); end	
	assert(ALU_A == AluOp) else begin errors++; $display("AluOp Error"); end
	

	@ (posedge Clock)
	#20 OpCode = ADD;
	while(c.state != c.Execute)
		#1000;
	#20 assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(0 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(1 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcInc) else begin errors++; $display("PcSel Error"); end
	assert(0 == Op1Sel) else begin errors++; $display("Op1Sel Error"); end	
	assert(ALU_ADD == AluOp) else begin errors++; $display("AluOp Error"); end

	@ (posedge Clock)
	#20 OpCode = MULT;
	while(c.state != c.Execute)
		#1000;
	#20 assert(1 == PcWe) else begin errors++; $display("PcWe Error"); end
	assert(0 == RegWe) else begin errors++; $display("RegWe Error"); end
	assert(1 == AccWe) else begin errors++; $display("AccWe Error"); end
	assert(PcSel == PcInc) else begin errors++; $display("PcSel Error"); end
	assert(0 == Op1Sel) else begin errors++; $display("Op1Sel Error"); end	
	assert(ALU_MULT == AluOp) else begin errors++; $display("AluOp Error"); end

	if (errors == 0)
		$display("Simulation PASSED");
	else
		$display("Simulation FAILED with %d errors", errors);
	
	#1000 $stop();
end
endmodule

