clc
clear 
close all

I = imread('cameraman.tif');
I = im2double(I);
[row col] = size(I);
N = row;
delta = 0.1;
n = 1000;

[gx,gy] = gradient(I);
gim = sqrt(gx.^2+gy.^2);
T = max(gim(:))/4; %threshold

%kap
kappa = 1./(1+(gim./T).^2);

diff_im = anisodiff2D(I, 20, 0.1, kappa, 2);
imshow(diff_im)