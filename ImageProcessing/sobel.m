clc;
close all;
clear all;
A=imread('cameraman.tif');
imshow(A);title('原图');
x_mask=[-1 0 1; -2 0 2;-1 0 1];
y_mask=[1 2 1;0 0 0;-1 -2 -1];
I=im2double(A);%将图像转化为双精度
dx=imfilter(I,x_mask);%计算x方向的梯度分量
dy=imfilter(I,y_mask);%计算y方向的梯度分量
grad=sqrt(dx.*dx+dy.*dy);%计算梯度
grad=mat2gray(grad);%将梯度矩阵转为灰度图像
level=graythresh(grad);%计算灰度阈值
BW=im2bw(grad,level);%用阈值分割图像
figure,imshow(BW);%显示分割后的图像即边缘图像
title('sobel')