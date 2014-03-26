// datapath.sv
// Writen by seblovett
// Date Created Tue 25 Feb 2014 17:09:55 GMT
// <+Last Edited: Tue 25 Feb 2014 20:55:37 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module datapath #(parameter n = 8) (
	input wire [n-1:0] MemData, Switches,
	output logic [n-1:0] MemAddr, LEDs,
	input wire  Clock, nReset, RegWe, ImmSel, WDataSel, AccStore, Op1Sel, //Op2Sel,
	input opcodes::alu_functions_t AluOp,
	input opcodes::PcSel_t PcSel

);

timeunit 1ns; timeprecision 1ps;
import opcodes::*;

logic [n-1:0] AluA, Imm, WData, Pc, Acc;
wire  [n-1:0]  RegData, AccIn;

assign Imm  = (ImmSel) ? {MemData[3:0], 4'b0000} : { 4'b0000, MemData[3:0]};
assign AluA = (Op1Sel) ? Imm : RegData;
//assign AluB = (Op2Sel) ? Pc  : Acc;
assign LEDs = Acc;
assign WData = (WDataSel) ? Switches[7:0] : Acc;
//program counter
always_ff @ (posedge Clock or negedge nReset)
begin : PcReg
	if (!nReset)
		Pc = 0;
	else
		case (PcSel)
			PcInc: Pc <= Pc + 1'd1;
			PcJmp: Pc <= AccIn; //jump to ALU result
		endcase
end
assign MemAddr = Pc;

//Accumulator
always_ff @ (posedge Clock or negedge nReset)
begin : AccReg
	if (!nReset)
		Acc = 0;
	else
		if(AccStore)
			Acc <= AccIn;
end



registers #(.n(n), .addr_width(4), .regcount(11) ) 
 r ( 
        .Clock(Clock), 
//	.nReset(nReset), 
			.WE   (RegWe),  //control signals
        .Rs1  (MemData[3:0]), 
        .Rd1  (RegData), 
        .Data (WData)
);


alu #(.n(n)) //n - data bus width
alu1
(
        .a(AluA), 
	.b(Acc),
        .Function(AluOp),
        .q(AccIn)
);
endmodule

