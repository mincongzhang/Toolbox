function [psnr]=Bartworth
%n step Butterworth, d0 is cut off frequency,d is the frequency
n = 2;
d0 = 1;
noise = 0.01;
%图像
I=imread('box.jpg');
I=rgb2gray(I);
subplot(3,3,1),imshow(I);title('原始的灰度图 lena');
[N1,N2]=size(I);

%原始图像频谱
F=fft2(im2double(I));%FFT
F=fftshift(F);%FFT频谱平移
F=abs(F);
T=log(F+1);%频谱对数变换,加对数后可以放大波动
[f1,f2] = freqspace([N1,N2],'meshgrid');%确定加噪声的图像的频率空间
subplot(3,3,4);mesh(f1,f2,T);title('原始图像的频谱');

%图像叠加高斯噪声
G=imnoise(I,'gaussian',0,noise);   % 叠加高斯噪声
subplot(3,3,2),imshow(G);title('加高斯噪声的图像 lena');

%加噪声的图像频谱
F=fft2(im2double(G));%FFT
F=fftshift(F);%FFT频谱平移
F=abs(F);
T=log(F+1);%频谱对数变换,加对数后可以放大波动

[f1,f2] = freqspace([N1,N2],'meshgrid');%确定加噪声的图像的频率空间
subplot(3,3,5);mesh(f1,f2,T);title('加噪声图像的频谱');

%通过Butterworth滤波器
%说明：
%d0是指定的非负数值，即为截止频率，d(u,v)是(u,v)点距频率矩形原点的距离。
%如果要研究的图像尺寸为N1×N2，它的变换也有相同的尺寸
%由于变换被中心化了，所以，频率矩形的中心在(u,v)=(N1／2,N2／2)处。
f=double(G);
g=fft2(f);
g=fftshift(g);
[N1,N2]=size(g);
n1=fix(N1/2);
n2=fix(N2/2);
for i=1:N1
  for j=1:N2
      d=sqrt((i-n1)^2+(j-n2)^2);
      h=1/(1+0.414*(d/d0)^(2*n));  %ε^2=0.414，Ap=1.5dB
      H(i,j)=h;
      result(i,j)=h*g(i,j);
  end
end

%滤波器二维频率响应
[f1,f2] = freqspace([N1,N2],'meshgrid');%确定二维频率响应的频率空间
subplot(3,3,8),mesh(f1,f2,H);title('Butterworth频率响应');

%滤波后的图像
result=ifftshift(result);
X2=ifft2(result);
J=uint8(real(X2));
subplot(3,3,3),imshow(J);title('滤波后的 lena');

%图像频谱
F=fft2(im2double(J));%FFT
F=fftshift(F);%FFT频谱平移
F=abs(F);
T=log(F+1);%频谱对数变换,加对数后可以放大波动
[f1,f2] = freqspace([N1,N2],'meshgrid');%确定加噪声的图像的频率空间
subplot(3,3,6);mesh(f1,f2,T);title('滤波后的频谱');

%计算峰值性噪比
im_original = double(I);
im_restored = double(J);

psnr = 20*log10(max(im_original(:))/sqrt(mean2((im_restored-im_original).^2)))




