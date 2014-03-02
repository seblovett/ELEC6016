// cpu_stim.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:23:59 GMT
// <+Last Edited: Sun 02 Mar 2014 22:53:30 GMT by hl13g10 on hart2.ecs.soton.ac.uk +>


module cpu_stim ();

timeunit 1ns; timeprecision 1ps;


parameter n = 8;
logic Clock, Reset;
logic [9:0] Switches;
wire [n-1: 0] LEDs;

cpu #(.n(n)) c (.*);
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
	Switches = 10'b0010100101;
        Reset = 0;
        #100 Reset = 1;
        #1000 Reset = 0;
	#18000 Switches[8] = 1;//load x
	#3000  Switches[8] = 0;
	#2000  Switches[8] = 1;//load y
	#2000  Switches[8] = 0; //go!
	#30000 Switches[8] = 1; //x shown, now show y
	#2000  Switches[8] = 0; //restart!
	//#100000 $stop();
end

always
begin
	#1000 if ( c.d.Pc == 8'hFF )
		$stop();
end

endmodule

