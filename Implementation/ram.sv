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
  `define prog_file  "transform.hex"
`endif

`ifdef ram_access_time
  // already defined - do nothing
`else
  `define ram_access_time 500ns
`endif


module ram #(parameter n = 8, parameter pc_n = 8) (
	input wire Clock,
	input wire [pc_n - 1:0] Address,
	output logic [n - 1:0] Data
  );

timeunit 1ns;
timeprecision 100ps;

//wire [10:0] Address = Bus.Address[10:0];  

logic [n - 1:0] Data_stored [ 64 : 0 ];

initial
  #1ns // This delay allows for program file to
       // be written within the same simulation
       $readmemh(`prog_file,Data_stored);

always_ff @ (posedge Clock)
begin
	Data <= Data_stored[Address];
end
endmodule
