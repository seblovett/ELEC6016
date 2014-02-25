# SimVision command script bitslice.tcl for bitslice
# created by ext2svmod 5.5

database -open waves
probe -all -depth all -database waves


simvision {

# List of signals to monitor defined here
#
set wave_signal_list {
  cpu_stim.Clock
  cpu_stim.nReset
  cpu_stim.MemAddr
  cpu_stim.MemData
  cpu_stim.Switches
  cpu_stim.LEDs
  cpu_stim.c.pc
  cpu_stim.c.PcWait
  cpu_stim.c.c.OpCode
  cpu_stim.c.c.Cond
  cpu_stim.c.c.AccStore
  cpu_stim.c.Acc
  cpu_stim.c.RegData
  cpu_stim.c.AluOp
  cpu_stim.c.WData
  cpu_stim.c.WDataSel
  cpu_stim.c.RegWe
  cpu_stim.c.r.regs
  cpu_stim.r.Data_stored
}

# View Results
#
window new WaveWindow -name "Waves for ELEC6016 CPU"
waveform add -using "Waves for ELEC6016 CPU" -signals $wave_signal_list
waveform xview zoom -using "Waves for ELEC6016 CPU" -outfull

}

