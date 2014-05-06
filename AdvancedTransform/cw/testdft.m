function testdft ()

w=1;
T=10;
s=ones(1,64);
s1 = ((1:64)-1);
s2 = sin(((1:64)-1)*2*pi*w/100);
s3 = [0:31 32:-1:1]<T;

figure,stem4(fftshift(dft(s)));
figure,stem4(fftshift(dft(s1)));
figure,stem4(fftshift(dft(s2)));
figure,stem4(fftshift(dft(s3)));
end

