// cpu.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:12:41 GMT
// <+Last Edited: Tue 25 Feb 2014 18:22:56 GMT by hl13g10 on hind.ecs.soton.ac.uk +>
`include "options.sv";

module cpu #(parameter n = 8) ( //n - bus width
	input wire Clock, nReset, 
	input wire [9:0] Switches,
`ifdef demo
	output logic [9:0] LEDs
`else
	output logic [n-1: 0] LEDs
`endif	
	);

timeunit 1ns; timeprecision 1ps;
import opcodes::*;

alu_functions_t AluOp;
PcSel_t PcSel;
logic[n-1:0] MemData;
wire [n-1:0] MemAddr; 
wire RegWe, WDataSel, AccStore, Op1Sel, ImmSel;

ram r (.Clock(Clock), .Address(MemAddr), .Data(MemData));

`ifdef demo
	always_comb
	begin
		case (opcodes_t'(MemData[7:4]))
			WAIT0: LEDs[9:8] = 2'b01;
			WAIT1: LEDs[9:8] = 2'b10;
			default: LEDs[9:8] = 2'b00;
		endcase
	end
`endif
control c 
(
	.Clock(Clock),
	.nReset(nReset),
	.RegWe(RegWe),
	.AluOp(AluOp),
	.OpCode(opcodes_t'(MemData[7:4])),
	.WDataSel(WDataSel),
	.PcSel(PcSel),
	.AccStore(AccStore),
	.Sw8(Switches[8]),
	.Op1Sel(Op1Sel),
//	.Op2Sel(Op2Sel),
	.ImmSel(ImmSel)
);

datapath d
(
	.ImmSel(ImmSel),
	.MemData(MemData),
	.MemAddr(MemAddr),
	.Switches(Switches[7:0]),
	.LEDs(LEDs[7:0]),
	.Clock(Clock),
	.nReset(nReset),
	.RegWe(RegWe),
	.AluOp(AluOp),
	.WDataSel(WDataSel),
	.PcSel(PcSel),
	.AccStore(AccStore),
	.Op1Sel(Op1Sel),
//	.Op2Sel(Op2Sel)
);

endmodule

