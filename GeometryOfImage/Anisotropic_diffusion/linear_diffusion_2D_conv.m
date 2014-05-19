clc
clear 
close all

Img = imread('cameraman.tif');
% I = imresize(I, 2);
Img = im2double(Img);
[row col] = size(Img);
N = row;

I = eye(N);
delta = 0.1;
Dx = [-1 2 -1];
Dy = Dx';

fk = Img;
for i = 1:100
    f_half = I\fk +delta/2*conv2(fk,Dy,'same');
    fk = 

end