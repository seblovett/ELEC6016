// cpu_stim.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:23:59 GMT
// <+Last Edited: Wed 02 Apr 2014 11:08:50 BST by hl13g10 on hind.ecs.soton.ac.uk +>


module cpu_stim ();

timeunit 1ns; timeprecision 1ps;


parameter n = 8;
logic Clock, nReset;
logic [8:0] SW;
wire [7: 0] LED;

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
        nReset = 1;
        #100 nReset = 0;
        #1000 nReset = 1;
end
int errors;
task CheckTransform;// (logic[7:0] x, y);
	input logic [7:0] x1,y1,x2,y2;
	$display("x1 = %d\ny1 = %d", x1,y1);
	SW[7:0] = x1;
	#60000 SW[8] = 1; //load x1
	#10000 SW[8:0] = y1;
	#10000 SW[8] = 1; //load y1
	#10000 SW[8] = 0; //Go!
	#60000  assert(LED[7:0] == x2)	
		$display("x2 = %d", x2);
	else begin 
		$display("X Fail.\nx2 = %d. (Should be %d)", LED[7:0], x2);
		errors++; 
	end

	SW[8] = 1; //show y
	#5000	assert(LED[7:0] == y2) 
		$display("y2 = %d", y2);
	else begin 
		$display("Y Fail.\ny2 = %d. (Should be %d)", LED[7:0], y2);
		errors++; 
	end
	#3000 SW = 0;
	#10000 ;
endtask
initial
begin
	errors = 0;
	SW = 0;
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

