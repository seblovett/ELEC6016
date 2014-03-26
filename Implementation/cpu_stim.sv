// cpu_stim.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:23:59 GMT
// <+Last Edited: Wed 26 Mar 2014 12:44:59 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


module cpu_stim ();

timeunit 1ns; timeprecision 1ps;


parameter n = 8;
logic Clock, nReset;
logic [9:0] Switches;
wire [7: 0] LEDs;

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
	Switches = 10'b0000010000;
        nReset = 1;
        #100 nReset = 0;
        #1000 nReset = 1;
//	#50000 Switches[8] = 1;//load x
//	#3000  Switches[8] = 0;
//	#2000  Switches[8] = 1;//load y
//	#2000  Switches[8] = 0; //go!
//	#30000 Switches[8] = 1; //x shown, now show y
//	#2000  Switches[8] = 0; //restart!
	//#100000 $stop();
end
initial
begin
	#60000 Switches[8] = 1; //load x  = 16
	#10000 Switches = 10'b0000001000;
	#10000 Switches[8] = 1; //load y
	#10000 Switches[8] = 0; //Go!
	#60000 Switches[8] = 1; //show y
	#40000 $stop();
end
always
begin
	#1000 if ( c.d.Pc == 8'hFF )
		$stop();
end

endmodule

