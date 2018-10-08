cd $DSN\src
asim -callbacks  -ieee_nowarn  -advdataflow  top_fft_tb tb_architecture
run -all
