function testmy_fft()

w=1;
T=20;
s=ones(1,64);
s1 = ((1:64)-1);
%s2 = sin(((1:64)-1)*2*pi*w/100);
%s3 = [0:31 32:-1:1]<T;

figure,stem4(fftshift(my_fft(s)));
figure,stem4(fftshift(my_fft(s1)));
%figure,stem4(fftshift(my_fft(s2)));
%figure,stem4(fftshift(my_fft(s3)));

end