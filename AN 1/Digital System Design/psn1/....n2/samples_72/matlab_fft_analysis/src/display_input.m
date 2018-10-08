figure('Position',pos1,'Name','Input signal with window function','NumberTitle','off');
h = plot(fft_Qin);
title(windows1024(w).name);
axis([0,1025,-Inf,-Inf]);
