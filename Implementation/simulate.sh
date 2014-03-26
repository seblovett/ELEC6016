#! /bin/bash


# HELP function
function printHelp (){
   echo "-------- HELP --------"
   echo "Parameter 1: Module"
   ls | grep _stim.sv
   echo "N.B. run without '_stim.sv' after name"
#   echo "   alu"
#   echo "   control"
#   echo "   cpu_core"
#   echo "   datapath"
#   echo "   regBlock"
   echo "Paramter 2: GUI"
   echo "   no_gui  "
   echo "   gui      (default)"
}


# GUI Option
cmd="ncverilog -sv"
gui="$2"
gui=${gui//[-.]/} # Remove tag


# Which module to test
module="$1"
module=${module//[-.]/} # Remove tag


if [ "gui" == $gui ]; then
	
	cmd="$cmd +gui +ncaccess+r"
	if [ -f "${module}.tcl" ]; then
		cmd="$cmd +tcl+${module}.tcl"
	fi
else
	cmd="$cmd -exit"
fi
#HSL: much simpler
if [ -f "${module}_stim.sv" ]; then
	cmd="$cmd +libext+.sv -y . ${module}_stim.sv opcodes.svh"
else
	echo "Unkown module $module"
	printHelp;
	exit 1;
fi
#cmd="$cmd +libext+.sv"

echo $cmd
$cmd  # Call SimVision


# I am sure there's a point for these but...
# HSL: if this line is included, you can not reinvoke simulator. Maybe best to
# have a clean script?
#rm -rf ncverilog.log ncverilog.key waves.shm INCA_libs
