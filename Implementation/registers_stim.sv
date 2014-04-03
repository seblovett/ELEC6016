// registers_stim.sv
// Writen by seblovett
// Date Created Mon 17 Feb 2014 10:31:52 GMT
// <+Last Edited: Thu 03 Apr 2014 20:57:25 BST by hl13g10 on hind.ecs.soton.ac.uk +>


module registers_stim ();

timeunit 1ns; timeprecision 1ps;

parameter n = 8;
parameter regcount = 16;
parameter addr_width = 4;

logic Clock, WE;  //control signals
wire  [n-1:0] Rd1;
logic [4:0] Rs1;
logic [n-1:0] Data, temp;

registers #(.n(n), .addr_width(addr_width), .regcount(regcount)) r (.*);

//clock
always
begin
        Clock = 0;
        #250 Clock = 1;
        #500 Clock = 0;
        #250 Clock = 0;
end

int errors;
//begin listing
task WriteandRead;
	Data =$random();
	temp = Data;
	Rs1 = $random();
	WE = 1;
	@ (posedge Clock) //write clock edge
	#20 WE = 0;
	Data = $random(); //change the input
	@ (posedge Clock) //need to wait a cycle to get the data back
	#20 assert(Rd1 == temp) else begin 
		errors++; 
		$display("Write/Read Error"); 
	end
	@ (posedge Clock) //check that the data persists with new input, WE = 0;
	#20 assert(Rd1 == temp) else begin 
		errors++; 
		$display("Persist Error"); 
	end 
endtask

int i;
initial 
begin
	i = 0;
	errors = 0;
	WE = 0;
	temp = 0;
	Rs1 = 0;
	Data=0;
	#1000
	for ( i = 0; i < 100; i++)
		WriteandRead();
	
	if(errors == 0)
		$display("Simulation PASSED");
	else
		$display("Simulation FAILED with %d errors", errors);
	$stop();
end


initial
begin
	$display("Time \tClock\tRs1\tRd1\tWE\tData");
	$monitor("%0dns \t%d\t%d \t%d\t%d\t%d",$time,Clock,Rs1, Rd1, WE, Data);
end
endmodule

