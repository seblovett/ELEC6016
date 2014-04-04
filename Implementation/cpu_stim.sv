// cpu_stim.sv
// Writen by seblovett
// Date Created Tue 18 Feb 2014 23:23:59 GMT
// <+Last Edited: Fri 04 Apr 2014 10:17:26 BST by hl13g10 on octopus +>


module cpu_stim ();

timeunit 1ns; timeprecision 1ps;

parameter n = 8;
logic Clock, nReset;
logic [8:0] SW;
wire [7: 0] LED;

cpu #(.n(n)) c (.*);

//Globals
int errors, i;
logic signed [7:0] x1t, x, y1t, y;

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
//begin listing
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

function logic [15:0] CalculateTransform(logic signed [7:0] x1, y1);
	automatic logic signed [7:0] x2c, y2c, a11, a12,a21,a22,b1,b2;
	automatic logic signed [15:0] temp1,temp2,temp3,temp4;
	a11 = 8'h40;
	a12 = 8'h90;
	a21 = 8'h90;
	a22 = 8'h60;
	b1  = 8'h05;
	b2  = 8'h0C;
	temp1 = a11 * x1;
	temp2 = a12 * y1;
	x2c = temp1[14:7] + temp2[14:7] + b1;
	temp3 = a21 * x1;
	temp4 = a22 * y1;
	y2c = temp3[14:7] + temp4[14:7] + b2;
	return {x2c, y2c};
endfunction
//end listing
initial
begin
//	a11 = 8'h40;
	i = 0;
	errors = 0;
	SW = 0;
	x1t = 16;
	y1t = 8;
	{x,y} = CalculateTransform(x1t,y1t);
	CheckTransform(x1t,y1t,x,y);
	x1t = 64;
	y1t = -64;
	{x,y} = CalculateTransform(x1t,y1t);
	CheckTransform(x1t,y1t,x,y);
	x1t = 0;
	y1t = 0;
	{x,y} = CalculateTransform(x1t,y1t);
	CheckTransform(x1t,y1t,x,y);
	x1t = -32;
	y1t = -32;
	{x,y} = CalculateTransform(x1t,y1t);
	CheckTransform(x1t,y1t,x,y);

	for ( i = 0; i < 10; i++)
	begin
		x1t = $random();
		y1t = $random();
		{x,y} = CalculateTransform(x1t,y1t);
		CheckTransform(x1t,y1t,x,y);
	end
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

