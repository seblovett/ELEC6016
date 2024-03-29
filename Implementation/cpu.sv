// cpu.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:12:41 GMT
// <+Last Edited: Thu 03 Apr 2014 12:48:12 BST by hl13g10 on octopus +>
//`include "options.sv"

module cpu #(parameter n = 8) ( //n - bus width
	input wire Clock, nReset, 
	input wire [8:0] SW,
`ifdef demo
	output logic [9:0] LED
`else
	output logic [7: 0] LED
`endif	
	);

	parameter pc_n = 6;
timeunit 1ns; timeprecision 1ps;
import opcodes::*;

alu_functions_t AluOp;
PcSel_t PcSel;
logic[n-1:0] MemData;
wire [pc_n-1:0] MemAddr; 
wire RegWe, WDataSel, AccWe, Op1Sel, ImmSel, PcWe;

ram #(.pc_n(pc_n) ) r (.Clock(Clock), .Address(MemAddr), .Data(MemData));

//Begin listing
`ifdef demo
	always_comb
	begin
		case (opcodes_t'(MemData[7:4]))
			WAIT0: LED[9:8] = 2'b01;
			WAIT1: LED[9:8] = 2'b10;
			default: LED[9:8] = 2'b00;
		endcase
	end
`endif
//endlisting
control c 
(
	.Clock(Clock),
	.nReset(nReset),
	.RegWe(RegWe),
	.AluOp(AluOp),
	.OpCode(opcodes_t'(MemData[7:4])),
	.WDataSel(WDataSel),
	.PcSel(PcSel),
	.AccWe(AccWe),
	.Sw8(SW[8]),
	.Op1Sel(Op1Sel),
//	.Op2Sel(Op2Sel),
	.ImmSel(ImmSel),
	.PcWe(PcWe)
);

datapath #( .n(n),  .pc_n(pc_n)) d
(
	.ImmSel(ImmSel),
	.MemData(MemData),
	.Pc(MemAddr),
	.Switches(SW[n-1:0]),
	.LEDs(LED[n-1:0]),
	.Clock(Clock),
	.nReset(nReset),
	.RegWe(RegWe),
	.AluOp(AluOp),
	.WDataSel(WDataSel),
	.PcSel(PcSel),
	.AccWe(AccWe),
	.Op1Sel(Op1Sel),
	.PcWe(PcWe)
//	.Op2Sel(Op2Sel)
);


endmodule

