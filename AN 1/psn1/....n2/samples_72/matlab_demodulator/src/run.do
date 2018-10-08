cd $DSN\src
asim +access +w -pli "$ALDEC/BIN/aldec_matlab_cosim.dll" -callbacks DSP_test

wave CLK
wave RDY
wave RESET
wave -notation 2compl -analog -height 64 -color 0,128,0  DATA
wave ACK_Bessel
wave ACK_simple
wave -dec -analog -height 64 -color 0,128,128 UUT/B 
wave -dec -notation 2compl -analog -height 96 -color 255,0,0  OUT_simple
wave -dec -notation 2compl -analog -height 96 -color 255,0,0  OUT_Bessel
wave sample_no

run
