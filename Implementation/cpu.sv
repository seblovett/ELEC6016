// cpu.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:12:41 GMT
// <+Last Edited: Tue 25 Feb 2014 18:22:56 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module cpu #(parameter n = 8) ( //n - bus width
	input wire Clock, Reset, 
	input wire [9:0] Switches,
	output logic [n-1: 0] LEDs);

timeunit 1ns; timeprecision 1ps;
import opcodes::*;

alu_functions_t AluOp;
PcSel_t PcSel;
logic[n-1:0] MemData;
wire [n-1:0] MemAddr; 
wire RegWe, WDataSel, AccStore, Op1Sel, Op2Sel, ImmSel;

ram r (.Clock(Clock), .Address(MemAddr), .Data(MemData));

control c 
(
	.Clock(Clock),
	.Reset(Reset),
	.RegWe(RegWe),
	.AluOp(AluOp),
	.OpCode(MemData[7:4]),
	.WDataSel(WDataSel),
	.PcSel(PcSel),
	.AccStore(AccStore),
	.Sw8(Switches[8]),
	.Op1Sel(Op1Sel),
	.Op2Sel(Op2Sel),
	.ImmSel(ImmSel)
);

datapath d
(
	.ImmSel(ImmSel),
	.MemData(MemData),
	.MemAddr(MemAddr),
	.Switches(Switches[7:0]),
	.LEDs(LEDs),
	.Clock(Clock),
	.Reset(Reset),
	.RegWe(RegWe),
	.AluOp(AluOp),
	.WDataSel(WDataSel),
	.PcSel(PcSel),
	.AccStore(AccStore),
	.Op1Sel(Op1Sel),
	.Op2Sel(Op2Sel)
);

endmodule

