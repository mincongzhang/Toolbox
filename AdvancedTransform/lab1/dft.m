function sw = dft(st)
%   DFT 
%   Author: Mincong Zhang

M = length(st);
N=M;
WN = exp(2*pi*j/N);

%Main loop
for n=0:N-1
    temp = 0;
    for m=0 : M - 1
        temp = temp + st(m+1)*WN^(-n*m);
    end 
    sw(n+1) = temp;
end