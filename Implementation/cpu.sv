// cpu.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:12:41 GMT
// <+Last Edited: Tue 25 Feb 2014 12:32:07 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module cpu #(parameter n = 8) ( //n - bus width
	input wire Clock, Reset, 
	input wire [n-1:0] MemData,
	output logic [n-1:0] MemAddr,
	input wire [8:0] Switches,
	output logic [n-1: 0] LEDs);

timeunit 1ns; timeprecision 1ps;

wire RegWe;
wire  [n-1:0] RegData, AccIn;
logic [n-1:0] WData;
control c 
(
	.Clock(Clock),
	.Reset(Reset),
	.RegWe(RegWe),
	.AluOp(AluOp),
	.OpCode(MemData[7:5]),
	.Cond(MemData[4]),
	.WDataSel(WDataSel),
	.PcWait(PcWait)
);

assign LEDs = RegData;
//program counter
logic [7:0] pc;
always_ff @ (posedge Clock or posedge Reset)
begin : pcReg
	if (Reset)
		pc = 0;
	else
		if(PcWait)
			pc <= pc;
		else
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
        .a(RegData), 
	.b(Acc),
        .Function(AluOp),
        .q(AccIn)
);

endmodule
