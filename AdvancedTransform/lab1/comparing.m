function  comparing
%This function plots and compares the FFT speed to the DFT
%showing that fft function takes O(n log n) time rather than O(n2) time
%   Author: Mincong Zhang
end_s=100;
 
for n = 1:end_s
s = ones(1,n);
 
%Start time of DCT
dctTime = tic;
    dft(s); 
dctEndTime = toc(dctTime);
    loglog(n,dctEndTime,'.-');
    hold on;
 
%Start time of FFT
fftTime = tic;
    fft(s); 
fftEndTime = toc(fftTime);
    loglog(n,fftEndTime,'x-');
end
xlabel('n'); 
ylabel('time'); 
legend('DFT','FFT'); 
end

