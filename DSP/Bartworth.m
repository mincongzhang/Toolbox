function [psnr]=Bartworth
%n step Butterworth, d0 is cut off frequency,d is the frequency
n = 2;
d0 = 1;
noise = 0.01;
%ͼ��
I=imread('box.jpg');
I=rgb2gray(I);
subplot(3,3,1),imshow(I);title('ԭʼ�ĻҶ�ͼ lena');
[N1,N2]=size(I);

%ԭʼͼ��Ƶ��
F=fft2(im2double(I));%FFT
F=fftshift(F);%FFTƵ��ƽ��
F=abs(F);
T=log(F+1);%Ƶ�׶����任,�Ӷ�������ԷŴ󲨶�
[f1,f2] = freqspace([N1,N2],'meshgrid');%ȷ����������ͼ���Ƶ�ʿռ�
subplot(3,3,4);mesh(f1,f2,T);title('ԭʼͼ���Ƶ��');

%ͼ����Ӹ�˹����
G=imnoise(I,'gaussian',0,noise);   % ���Ӹ�˹����
subplot(3,3,2),imshow(G);title('�Ӹ�˹������ͼ�� lena');

%��������ͼ��Ƶ��
F=fft2(im2double(G));%FFT
F=fftshift(F);%FFTƵ��ƽ��
F=abs(F);
T=log(F+1);%Ƶ�׶����任,�Ӷ�������ԷŴ󲨶�

[f1,f2] = freqspace([N1,N2],'meshgrid');%ȷ����������ͼ���Ƶ�ʿռ�
subplot(3,3,5);mesh(f1,f2,T);title('������ͼ���Ƶ��');

%ͨ��Butterworth�˲���
%˵����
%d0��ָ���ķǸ���ֵ����Ϊ��ֹƵ�ʣ�d(u,v)��(u,v)���Ƶ�ʾ���ԭ��ľ��롣
%���Ҫ�о���ͼ��ߴ�ΪN1��N2�����ı任Ҳ����ͬ�ĳߴ�
%���ڱ任�����Ļ��ˣ����ԣ�Ƶ�ʾ��ε�������(u,v)=(N1��2,N2��2)����
f=double(G);
g=fft2(f);
g=fftshift(g);
[N1,N2]=size(g);
n1=fix(N1/2);
n2=fix(N2/2);
for i=1:N1
  for j=1:N2
      d=sqrt((i-n1)^2+(j-n2)^2);
      h=1/(1+0.414*(d/d0)^(2*n));  %��^2=0.414��Ap=1.5dB
      H(i,j)=h;
      result(i,j)=h*g(i,j);
  end
end

%�˲�����άƵ����Ӧ
[f1,f2] = freqspace([N1,N2],'meshgrid');%ȷ����άƵ����Ӧ��Ƶ�ʿռ�
subplot(3,3,8),mesh(f1,f2,H);title('ButterworthƵ����Ӧ');

%�˲����ͼ��
result=ifftshift(result);
X2=ifft2(result);
J=uint8(real(X2));
subplot(3,3,3),imshow(J);title('�˲���� lena');

%ͼ��Ƶ��
F=fft2(im2double(J));%FFT
F=fftshift(F);%FFTƵ��ƽ��
F=abs(F);
T=log(F+1);%Ƶ�׶����任,�Ӷ�������ԷŴ󲨶�
[f1,f2] = freqspace([N1,N2],'meshgrid');%ȷ����������ͼ���Ƶ�ʿռ�
subplot(3,3,6);mesh(f1,f2,T);title('�˲����Ƶ��');

%�����ֵ�����
im_original = double(I);
im_restored = double(J);

psnr = 20*log10(max(im_original(:))/sqrt(mean2((im_restored-im_original).^2)))




