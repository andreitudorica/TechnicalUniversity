N = 512;
N2 = N/2;

outputs(1,:) = out_bessel;
outputs(2,:) = out_simple;

f = 1000*(0:N2)/N ; %scale frequency range 0-500MHz
for i = 1:(floor (500/SFRQ))
    %extract indexes of harmonic frequencies of modulating signal
    [MM, Sfh(i)] = min( abs( f(1,:) - i*SFRQ ) );
end
for i = 1:(floor (500/CFRQ))
    %extract indexes of harmonic frequencies of carrier
    [MM, Cfh(i)] = min( abs( f(1,:) - i*CFRQ ) );
end
for m = 1:2
    Y=fft(outputs(m,:),N) ;
    My = abs(Y)/N2 ; %scale output
    My_bs(m,:) = My;
    MP(m) = My(Sfh(1))/Aout_ref; %scale amplitude to modulating signal
    SMh(1,:) = My(Sfh(1,:)); %extract amplitudes of signal harmonics
    CMh(1,:) = My(Cfh(1,:)); %extract amplitudes of carrier harmonics
    %calculate THD
    SMpow = SMh .* SMh; % square of signal
    CMpow = CMh .* CMh; % square of carrier
    nom = sum(SMpow) - SMpow(1); %nominator of signal
    Sdenom = sum(SMpow); %denominator of signal (total signal power)
    THD(m) = 100 * sqrt(nom)/sqrt(Sdenom); %THD of signal
    Cdenom = sum(CMpow); %denominator of carrier (total carrier power)
    SC_ratio(m) = 10 * log10(Cdenom/Sdenom);
end
THD_bessel = THD(1);
THD_simple = THD(2);
MP_bessel = MP(1);
MP_simple = MP(2);
SC_bessel = SC_ratio(1);
SC_simple = SC_ratio(2);
My_bessel = My_bs(1,:);
My_simple = My_bs(2,:);

%plot
figure(3)
f3p = get(2,'Position') ;
f3p(1)=f3p(1)-407 ;
f3p(2)=f3p(2)-368 ;
set(3,'Position',f3p)
plot(f(1:100),My_bessel(1:100))
title('Frequency content of Bessel filter output')
xlabel('frequency (MHz)')
grid on

figure(4)
f4p = get(3,'Position') ;
f4p(1)=f4p(1)+407 ;
f4p(2)=f4p(2) ;
set(4,'Position',f4p)
plot(f(1:100),My_simple(1:100))
title('Frequency content of simple filter output')
xlabel('frequency (MHz)')
grid on
