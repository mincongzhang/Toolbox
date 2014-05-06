function sw = my_fft(st)
% Recursive Implementation of Fast Fourer Transform
N = length(st);
% check length of N is 2^k
if (rem(log(N),log(2)))
    disp('slow_fft: N must be an exact power of 2');
    return;
end
WN = exp(2*pi*1i/N);
% split st into even and odd samples
st_even = st(1:2:end-1);
st_odd = st(2:2:end);
% implement recursion here...
if (N==2)
    g = st_even; % = st(0+1)
    h = st_odd; % = st(2)
    gg = [g g];
    hh = [h -h];
else
    g = my_fft(st_even);
    h = my_fft(st_odd);
    gg = [g g];
    hh = WN.^(-[0:N-1]).*[h h];
end
sw = gg+hh;


end

