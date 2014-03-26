// cpu_stim.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:23:59 GMT
// <+Last Edited: Wed 26 Mar 2014 13:46:25 GMT by hl13g10 on hind.ecs.soton.ac.uk +>


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
	//Switches = 10'b0000010000;
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
int errors;
task CheckTransform;// (logic[7:0] x, y);
	input logic [7:0] x1,y1,x2,y2;
	Switches[7:0] = x1;
	#60000 Switches[8] = 1; //load x1
	#10000 Switches[8:0] = y1;
	#10000 Switches[8] = 1; //load y1
	#10000 Switches[8] = 0; //Go!
	#60000  assert(LEDs[7:0] == x2) else begin $display("X Fail");
			errors++; end
	Switches[8] = 1; //show y
	#5000	assert(LEDs[7:0] == y2) else begin $display("Y Fail");
			errors++; end
	#3000 Switches = 0;
	#10000 ;
endtask
initial
begin
	errors = 0;
	Switches = 0;
	CheckTransform(16,8,6,4);
	CheckTransform(64,-64,93,-92);
	CheckTransform(0,0,5,12);
	CheckTransform(-32,-32,17,16);
//	CheckTransform();
	#40000 
	if ( errors == 0)
		$display("Simulation PASSED");
	else
		$display("Simulation FAILED");
	$stop();
end
always
begin
	#1000 if ( c.d.Pc == 8'hFF )
		$stop();
end

endmodule

