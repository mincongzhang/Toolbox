clc;
close all;
clear all;

O=imread('Lena512_ASCII.pgm');
I=O;

I_info=size(I);
M=I_info(1); %the width of the image
N=I_info(2); %the height of the image
%I saves the information of image modelgray.jpg

imshow(I);title('original image');
%display original image

I64=floor(I/4)*4+2;
III=double(I);
I6464=double(I64);
I64_mse=sum(sum((III-I6464).^2))/(M*N);
mean64=sum(sum(I64))/(M*N);
mean64_2=mean64*ones(M,N);
I64_2=double(I64)-mean64_2;
sigma2_64=sum(sum((I64_2).^2))./(M*N);
I64_snr=10*log(sigma2_64/I64_mse);
I64_psnr=10*log(255^2/I64_mse);
fprintf('\nLevel=64, MSE/SNR/PSNR are  %f / %f / %f  separately.\n',I64_mse,I64_snr,I64_psnr);
figure;
imshow(I64);title('quantized image with L=64');
%level=64
%display the MSE/SNR/PSNR and the quantized image

I32=floor(I/8)*8;
I32_mse=sum(sum((I-I32).^2))/(M*N);
I32_snr=255^2/I32_mse;
I32_psnr=10*log(I32_snr);
fprintf('\nLevel=32, MSE/SNR/PSNR are  %f / %f / %f  separately.\n',I32_mse,I32_snr,I32_psnr);
figure;
imshow(I32);title('quantized image with L=32');
%level=32
%display the MSE/SNR/PSNR and the quantized image

I16=floor(I/16)*16;
I16_mse=sum(sum((I-I16).^2))/(M*N);
I16_snr=255^2/I16_mse;
I16_psnr=10*log(I16_snr);
fprintf('\nLevel=16, MSE/SNR/PSNR are  %f / %f / %f  separately.\n',I16_mse,I16_snr,I16_psnr);figure;
imshow(I16);title('quantized image with L=16');
%level=16
%display the MSE/SNR/PSNR and the quantized image

I8=floor(I/32)*32;
I8_mse=sum(sum((I-I8).^2))/(M*N);
I8_snr=255^2/I8_mse;
I8_psnr=10*log(I8_snr);
fprintf('\nLevel=08, MSE/SNR/PSNR are  %f / %f / %f  separately.\n',I8_mse,I8_snr,I8_psnr);figure;
imshow(I8);title('quantized image with L=8');
%level=8
%display the MSE/SNR/PSNR and the quantized image