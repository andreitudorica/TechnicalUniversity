alog $DSN\src\filter_simple.v
alog $DSN\src\filter_bessel.v
alog $DSN\src\abs.v
comp $DSN\src\DSP.bde
alog -incdir "$VLIB/aldec/src" -pli "$ALDEC/BIN/aldec_matlab_cosim.dll"  $DSN\src\dsp_test.bde