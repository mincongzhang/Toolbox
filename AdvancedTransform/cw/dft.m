function sw = dft(st)
% DFT - Discrete Fourier Transform
M = length(st);
N = M;
WN = exp(-2*pi*1i/N);
% Main loop
for n=0:N-1
    temp = 0;
    for m=0:M-1
        temp=temp+st(m+1).*(WN.^(m.*n));
    end
sw(n+1) = temp;
end
