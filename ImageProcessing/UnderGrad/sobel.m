clc;
close all;
clear all;
A=imread('cameraman.tif');
imshow(A);title('ԭͼ');
x_mask=[-1 0 1; -2 0 2;-1 0 1];
y_mask=[1 2 1;0 0 0;-1 -2 -1];
I=im2double(A);%��ͼ��ת��Ϊ˫����
dx=imfilter(I,x_mask);%����x������ݶȷ���
dy=imfilter(I,y_mask);%����y������ݶȷ���
grad=sqrt(dx.*dx+dy.*dy);%�����ݶ�
grad=mat2gray(grad);%���ݶȾ���תΪ�Ҷ�ͼ��
level=graythresh(grad);%����Ҷ���ֵ
BW=im2bw(grad,level);%����ֵ�ָ�ͼ��
figure,imshow(BW);%��ʾ�ָ���ͼ�񼴱�Եͼ��
title('sobel')