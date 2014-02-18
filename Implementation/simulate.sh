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
case $gui in
   "no_gui")      echo "No GUI";;
   *)             echo "GUI" ; cmd="$cmd +gui" ;; 
esac
cmd="$cmd +ncaccess+r"


# Which module to test
module="$1"
module=${module//[-.]/} # Remove tag
#case $module in
#   "alu")         cmd="$cmd   opcodes.svh    
#                              alu_stim.sv       
#                              alu.sv"           ;;
#   "control")     cmd="$cmd   opcodes.svh    
#                              control_stim.sv   
#                              control.sv"       ;;
#   "cpu_core")    cmd="$cmd   opcodes.svh    
#                              cpu_core_stim.sv  
#                              cpu_core.sv    
#                              control.sv  
#                              datapath.sv    
#                              alu.sv
#                              regBlock.sv
#                              trisBuf16.sv
#                              signExtend.sv"       ;;
#   "datapath")    cmd="$cmd   opcodes.svh        
#                              datapath_stim.sv  
#                              datapath.sv       
#                              alu.sv            
#                              regBlock.sv       
#                              trisBuf16.sv     ";;
#   "regBlock")    cmd="$cmd                  regBlock_stim.sv  regBlock.sv"                                       ;;
#   "trisreg")	  cmd="$cmd trisreg_stim.sv trisreg.sv";;
#   "regBlock")    cmd="$cmd   regBlock_stim.sv  
#                              regBlock.sv"      ;;
#   *)             echo "Unkown module $module"; printHelp; exit ;;
#esac
#HSL: much simpler
if [ -f ${module}_stim.sv ]; then
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
