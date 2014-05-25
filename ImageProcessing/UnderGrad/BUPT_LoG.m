function  BUPT_LoG(path,blockSize,sigma)
%BUPT_LoG
%Mincong Zhang
%This function firstly smooth the image with the gaussian lowpass filter
%Then apply the Laplacian operator to carry out a edge detection

[I,w,h,level]=pgmread(path);%'Lena512_ASCII.pgm'
[h w]=size(I);
smoothed_img=gauss_lowpass(I,blockSize,sigma);

%Laplace operator
kernel=[0 1 0;1 -4 1;0 1 0];%This is one Laplace operator that I use
%kernel=[1 1 1;1 -8 1;1 1 1]; This is another Laplace operator

filtered_img=conv2(smoothed_img,kernel,'same'); %return the same size as smoothed_img
imshow(filtered_img);
%imwrite(filtered_img,'BaboonLoG¦Ò=3.png','png');

%%%%%%%%%%%%%%%%%%%%%%%%%gaussian lowpass filter%%%%%%%%%%%%%%%%%%%%%%%%%%%
function filtered_img = gauss_lowpass(I,blockSize,variance)
%Mincong Zhang
% This function convolves an image with a Gaussian kernel.  

m=blockSize;
n=blockSize;

%calculate the center of the filter
k=floor([(m+1)/2 (n+1)/2]);
gauss_array=zeros(m,n);

%calculate the Gaussian kernel
for i=1:m 
    for j=1:n 
        %gauss_array(i,j)=exp(-((i^2+j^2)/(2*sigma^2))); %Gaussian kernel,separated equation for one dimension
        %gauss_array(i,j) =exp(-((i-k(1))^2+(j-k(2))^2/(2*sigma^2)));  %centered Gaussian kernel,separated equation for one dimension
        gauss_array(i,j) =exp(-((i-k(1))^2+(j-k(2))^2)/(4*variance))/(4*pi*variance);  %centered Gaussian kernel,for two dimension 
    end 
end 
I=double(I);%transform into double mode to do convolution
filtered_img=conv2(I,gauss_array,'same'); %convolve the noised image with the gauss array so that to do the gauss filter
end
end