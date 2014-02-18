// registers_tb.sv
// Writen by seblovett
// Date Created Mon 17 Feb 2014 10:31:52 GMT
// <+Last Edited: Mon 17 Feb 2014 11:33:56 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module registers_tb ();

timeunit 1ns; timeprecision 1ps;

parameter n = 8;
parameter regcount = 32;
parameter addr_width = 5;
logic Clock, Reset, WE;  //control signals
logic [n-1:0] Rd1, Rd2;
logic [4:0] Rs1, Rs2, Rw;
logic [n-1:0] Data;

registers #(.n(n), .addr_width(addr_width), .regcount(regcount)) r (.*);

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
	Reset = 0;
	#100 Reset = 1;
	#100 Reset = 0;
end

//write some data
initial 
begin
	Rs1 = 0; 
	Rs2 = 0;
	Data = 55;
	Rw = 0;
	WE = 0;
	#2000 WE = 1;
	#1000 Rs2 = 30; //test outside the bounds
	#3000 $stop();
end


initial
begin
	$display("Time \tReset\tClock\tRs1=Rd1\tRs2=Rd2\tWE\tData");
	$monitor("%0dns \t%d\t%d \t%d=%d\t%d=%d\t%d\t%d",$time,Reset, Clock,Rs1, Rd1, Rs2, Rd2, WE, Data);
end
endmodule

