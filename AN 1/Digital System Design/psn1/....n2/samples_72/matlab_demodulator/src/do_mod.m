t = 0:.001:1.024 ;
sw = fix(AMPL*sin(2*pi*CFRQ*t).*(1-DPTH*cos(2*pi*SFRQ*t))) ;
Aout_ref = AMPL*DPTH/2;
figure(1)
f1p = get(1,'Position') ;
f1p(1)=f1p(1)-200 ;
f1p(2)=f1p(2)-50 ;
f1p(3)=400 ;
f1p(4)=300 ;
set(1,'Position',f1p);
plot (t(1:1000),sw(1:1000))
title('Input wave')
xlabel('time (us)')
grid on

N = 1024;
N2 = N/2;
f = 1000*(0:N2)/N ; %scale frequency range 0-500MHz
Msw = abs(fft(sw,N));
figure(2);
f2p = get(1,'Position') ;
f2p(1)=f2p(1)+407 ;
f2p(2)=f2p(2);
set(2,'Position',f2p);
plot (f(1:100),Msw(1:100)/N2)
title('Spectrum of input wave')
xlabel('frequency (MHz)')
grid on
