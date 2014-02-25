///////////////////////////////////////////////////////////////////////
//
// ram module
//            2048 words.	0-2047
//
//
///////////////////////////////////////////////////////////////////////

`ifdef prog_file
  // already defined - do nothing
`else
  `define prog_file  "program.hex"
`endif

`ifdef ram_access_time
  // already defined - do nothing
`else
  `define ram_access_time 500ns
`endif


module ram(
	input wire [7:0] Address,
	output logic [7:0] Data
  );

timeunit 1ns;
timeprecision 100ps;

//wire [10:0] Address = Bus.Address[10:0];  

logic [7:0] Data_stored [ 0 : 2047 ];
logic delay;

initial
  delay = 0;

//always @(negedge nCE or Address)
//  if (! nCE)
//    begin
//      delay = 1;
//      #`ram_access_time
//      delay = 0;
//    end 

// The #20 delay here ensures that the data is available before nWait goes high
//assign #20 Bus.nWait = (delay && !nCE && (!Bus.nOE || !Bus.RnW)) ? 0 : 1'bz;

initial
  #1ns // This delay allows for program file to
       // be written within the same simulation
       $readmemh(`prog_file,Data_stored);


assign Data = Data_stored[Address];

endmodule
