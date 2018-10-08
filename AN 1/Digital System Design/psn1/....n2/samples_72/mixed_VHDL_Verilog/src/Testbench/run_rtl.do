quiet on
@onerror
{
goto end
}


SetActiveLib -work
				  
alog $DSN/src/and4.v
alog $DSN/src/and3.v
alog $DSN/src/and2.v
alog $DSN/src/oscil.v
acom $DSN/src/cb4ce.vhd
acom $DSN/src/c2or.vhd
alog $DSN/src/CRV.bde
acom $DSN/src/pfdiv.vhd
acom $DSN/src/filter.bde
acom $DSN/src/testbench/filter1_functional_tb.vhd
asim -advdataflow -ses filter_functional_tb tb_architecture

wave
wave -ports UUT/* 
run -all 
endsim

label end

quiet off
