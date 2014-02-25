// cpu_stim.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:23:59 GMT
// <+Last Edited: Tue 25 Feb 2014 10:33:50 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module cpu_stim ();

timeunit 1ns; timeprecision 1ps;


parameter n = 8;
logic Clock, Reset;
logic [n-1:0] MemData;
wire [n-1:0] MemAddr;


cpu #(.n(n)) c (.*);
ram r (.Address(MemAddr), .Data(MemData));
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
        #1000 Reset = 0;
	
	#2000 $stop();
end


endmodule

