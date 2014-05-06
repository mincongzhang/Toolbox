function sw = my_fft(st)
%   This function computes the FFT of a signal. 
%   Author: Mincong Zhang

% Recursive Implementation of Fast Fourer Transform
N = length(st);

% check length of N is 2^k
if (rem(log(N),log(2)))
  disp('slow_fft: N must be an exact power of 2')
  return
end
WN = exp(2*pi*j/N);
WN2 = exp(4*pi*j/N); % = WN^2
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
     %¦²£¨r=0£ºr=N/2-1£© 
    for (r=0:N/2-1)  
    g(r+1) = sum(  st_even .* WN2.^(-r*[0:N/2-1]) );
    h(r+1) = sum(  st_odd .* WN2.^(-r*[0:N/2-1]) );
    end
    gg = [g g];
    hh = WN.^(-[0:N-1]).*[h h];
  end
sw = gg+hh;
end
