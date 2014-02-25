// datapath.sv
// Writen by seblovett
// Date Created Tue 25 Feb 2014 17:09:55 GMT
// <+Last Edited: Tue 25 Feb 2014 17:24:52 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module datapath #(parameter n = 8) (
	input wire [n-1:0] MemData, Switches,
	output logic [n-1:0] MemAddr, LEDs,
	input wire  Clock, Reset, RegWe, ImmSel, WDataSel, PcWait, AccStore, LedStore, Op1Sel,
	input opcodes::alu_functions_t AluOp

);

timeunit 1ns; timeprecision 1ps;
import opcodes::*;

logic [n-1:0] AluA, Imm, WData;
wire  [n-1:0]  RegData, AccIn;

assign Imm  = (ImmSel) ? {MemData[3:0], 4'b0000} : {4'b0000, MemData[3:0]};
assign AluA = (Op1Sel) ? Imm : RegData;

always_ff @ (posedge Clock or posedge Reset)
begin : LedReg
	if (Reset)
		LEDs = 0;
	else
		if(LedStore)
			LEDs <= RegData;
end

//program counter
logic [7:0] pc;
always_ff @ (posedge Clock or posedge Reset)
begin : pcReg
	if (Reset)
		pc = 0;
	else
		if(!PcWait)
			pc <= pc + 1;
end
assign MemAddr = pc;

//Accumulator
logic [7:0] Acc;
always_ff @ (posedge Clock or posedge Reset)
begin : AccReg
	if (Reset)
		Acc = 0;
	else
		if(AccStore)
			Acc <= AccIn;
end

//Mux Wdata

assign WData = (WDataSel) ? Switches[7:0] : Acc;

registers #(.n(n), .addr_width(3), .regcount(8) ) 
 r ( 
        .Clock(Clock), 
	.Reset(Reset), 
	.WE   (RegWe),  //control signals
        .Rs1  (MemData[2:0]), 
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

