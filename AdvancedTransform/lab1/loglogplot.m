function  loglogplot
%   Author: Mincong Zhang

x = 1:100;
%DFT
loglog(x,(x.^2),'.-')

hold on
%FFT
loglog(x,x.*log(x),'x-')

%Draw info
xlabel('n'); 
ylabel('time'); 
legend('DFT','FFT'); 



%function test3=timecost(N)
%for n=0:N-1
%tic;
%st=ones(1,n+1);
%sw=dft(st);
%t(n+1)=toc;
%end
%loglog(N,t);