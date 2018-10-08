%complex FFTs 
%calculated by fft() built-in function
fft_Cin_whole = fft(fft_Qin,1024,2);
fft_Cin = fft_Cin_whole(1:512);
%processed by hardware
fft_Cout = fft_Qout(1:512) + fft_Iout(1:512) * i;

%normalize
mag_in = abs(fft_Cin);
mag_out = abs(fft_Cout);
pwr_in = mag_in.^2;
pwr_out = mag_out.^2;
total_pwr_in = sum(pwr_in)/512;
total_pwr_out = sum(pwr_out)/512;
if total_pwr_in > total_pwr_out
    ratio = sqrt(total_pwr_in/total_pwr_out);
    fft_Cout = fft_Cout * ratio;
else
    ratio = sqrt(total_pwr_out/total_pwr_in);
    fft_Cin = fft_Cin * ratio;
end

%calculate spectrum
mag_out = abs(fft_Cout);
mag_in = abs(fft_Cin);

%error
mag_err = (mag_in - mag_out)/max(mag_in);

%rms error
e_mag=sqrt(1/length(mag_in)*sum((mag_in-mag_out).^2)/sum(mag_in.^2));
