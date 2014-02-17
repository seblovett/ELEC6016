#!/bin/bash
# @file simulate.sh
# Date Created: Mon 17 Feb 2014 09:36:09 GMT by seblovett on hind.ecs.soton.ac.uk
# <+Last Edited: Mon 17 Feb 2014 11:09:32 GMT by hl13g10 on hind.ecs.soton.ac.uk +>

echo ELEC6016 Simulation



ncverilog -sv -q -y . +libext+.sv opcodes.svh $1_tb.sv
 

exit 0

