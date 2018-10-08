setactivelib -work
acom -dbg $DSN/src/sign.vhd
acom -dbg $DSN/src/mult.vhd
acom -dbg $DSN/src/mult1.vhd
acom -dbg $DSN/src/abs.vhd
simulinkgenmod -f -o "$WSP/Simulink/mult.m" mult beh
simulinkgenmod -f -o "$WSP/Simulink/m_abs.m" m_abs beh
simulinkgenmod -f -o "$WSP/Simulink/mult1.m" mult1 beh
simulinkgenmod -f -o "$WSP/Simulink/signum.m" signum beh
