function BUPT_DoG(path,blockSize,sigma)
%BUPT_DoG 
%Mincong Zhang
%This function approximates the gradient based on the first order derivative of a Gaussian.
%threshold is applied to increase the contrast

[I,w,h,level]=pgmread(path);%'Baboon512_ASCII.pgm'
[h w]=size(I);
smoothed_img=gauss_lowpass(I,blockSize,sigma);

%approximates the gradient
edge_img=gradient(smoothed_img,2,2);

%calculate the threshold of the grayscale
level=graythresh(edge_img);

%Convert image to binary image, based on threshold
BW=im2bw(edge_img,level);
imwrite(BW,'BaboonDoG¦Ò=3.png','png');
imshow(BW);



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