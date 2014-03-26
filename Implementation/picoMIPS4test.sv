// synthesise to run on Altera DE0 for testing and demo
module picoMIPS4test(
  input logic Clock, nReset,  // 50MHz Altera DE0 clock
  input logic [9:0] SW, // Switches SW0..SW9
  output logic [9:0] LED); // LEDs
  
  logic clk; // slow clock, about 10Hz
  
  counter c (.fastclk(Clock),.clk(clk)); // slow clk from counter
  
  // to obtain the cost figure, synthesise your design without the counter 
  // and the picoMIPS4test module using Cyclone IV E as target
  // and make a note of the synthesis statistics
  cpu myDesign (.Clock(clk), .SW(SW),.LED(LED), .nReset(nReset));
  
endmodule  