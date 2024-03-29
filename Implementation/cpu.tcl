# SimVision command script bitslice.tcl for bitslice
# created by ext2svmod 5.5

database -open waves
probe -all -depth all -database waves


simvision {

# List of signals to monitor defined here
#
set wave_signal_list {
  cpu_stim.Clock
  cpu_stim.Reset
  cpu_stim.c.MemAddr
  cpu_stim.c.MemData
  cpu_stim.Switches
  cpu_stim.LEDs
  cpu_stim.c.LedStore
  cpu_stim.c.d.Pc
  cpu_stim.c.d.PcSel
  cpu_stim.c.c.OpCode
  cpu_stim.c.c.AccStore
  cpu_stim.c.d.Acc
  cpu_stim.c.d.RegData
  cpu_stim.c.d.AluA
  cpu_stim.c.Op1Sel
  cpu_stim.c.Op2Sel
  cpu_stim.c.d.AluB
  cpu_stim.c.d.AccIn
  cpu_stim.c.AluOp
  cpu_stim.c.d.WData
  cpu_stim.c.WDataSel
  cpu_stim.c.RegWe
  cpu_stim.c.d.r.Rs1
  cpu_stim.c.d.r.regs
  cpu_stim.r.Data_stored
}

# View Results
#
window new WaveWindow -name "Waves for ELEC6016 CPU"
waveform add -using "Waves for ELEC6016 CPU" -signals $wave_signal_list
waveform xview zoom -using "Waves for ELEC6016 CPU" -outfull

}

