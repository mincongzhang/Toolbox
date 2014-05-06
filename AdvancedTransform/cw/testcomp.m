function testcomp()

i=0:10;
z = zeros(1,length(i));
z1 = z;

for n=1:length(i)
    s=ones(1,2^i(n));
    tic;
    dft(s);
    z(n)=toc;
    
    tic;
    for(k=1:1000)
        fft(s);
    end; 
    z1(n)=toc./1000;
end

x = 2.^i;
y = z;
y1 = z1;
loglog(x,y,'-s',x,y1);
title('DFT Loglog');


end

