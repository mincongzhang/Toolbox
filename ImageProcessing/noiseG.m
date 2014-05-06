function noiseG(path,noise)
%BUPT_add_Gaussian_noise
%Mincong Zhang

%[I,w,h,level]=pgmread(path);
%for colour image
[I,w,h,level]=ppmread(path);
A=uint8(I)

G=imnoise(A,'gaussian',0,noise) 

im_original = double(A);
im_distorted = double(G);

%MSE=sum(sum((im_original-im_distorted).^2))/(w*h)
%for colour image
MSE=sum(sum((sum(im_original-im_distorted)/3).^2))/(w*h)
PSNR = 20*log10(255/sqrt(MSE))

imshow(G);
imwrite(G,'BaboonRGBGaussian7%.png','png');
end

