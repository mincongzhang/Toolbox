function noiseSP(path)
%BUPT_add_'salt & pepper'_noise
%Mincong Zhang

%[I,w,h,level]=pgmread(path);
%for colour image
[I,w,h,level]=ppmread(path);
A=uint8(I)

S=imnoise(A,'salt & pepper') 

im_original = double(A);
im_distorted = double(S);

MSE=sum(sum(sum((im_original-im_distorted)/3).^2))/(w*h)
PSNR = 20*log10(255/sqrt(MSE))

imshow(S);
imwrite(S,'LenaRGBSalt&Pepper.png','png');
end