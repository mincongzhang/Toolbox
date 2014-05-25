function BUPT_lowpass()
%BUPT_LOWPASS 
%Mincong Zhang
%It is a lowpass that convolves an image with a Gaussian kernel
%the input noise value, sigma value, size of the kernel is in the process of this function


path='Lena512_ASCII.pgm';                
[I,w,h,level]=pgmread(path);
original_img=uint8(I);%change into binary to do the imnoise

%noise=input('input the noise power:');%input the noise power
noise=0.5;%lab required
noised_img=imnoise(original_img,'gaussian',0,noise);

%m=input('input size of the kernel:');%input the size of Gaussian kernel
%n=m;% I simply make the size be square
m=512;n=512; %lab required

%calculate the center of the filter
k=floor([(m+1)/2 (n+1)/2]);
sigma=input('input sigma:');
gauss_array=zeros(m,n);

%calculate the Gaussian kernel
for i=1:m 
    for j=1:n 
        %gauss_array(i,j)=exp(-((i^2+j^2)/(2*sigma^2))); %Gaussian kernel,separated equation for one dimension
        %gauss_array(i,j) =exp(-((i-k(1))^2+(j-k(2))^2/(2*sigma^2)));  %centered Gaussian kernel,separated equation for one dimension
        gauss_array(i,j) =exp(-((i-k(1))^2+(j-k(2))^2)/(4*sigma))/(4*pi*sigma);  %centered Gaussian kernel,for two dimension 
    end 
end 
noised_img=double(noised_img);%transform into double mode to do convolution
filtered_img=conv2(noised_img,gauss_array,'same'); %convolve the noised image with the gauss array so that to do the gauss filter

noised_img=uint8(noised_img);
filtered_img=uint8(filtered_img);

subplot(1,3,1);imshow(original_img);title('original image');
subplot(1,3,2);imshow(noised_img);title('noised image');
subplot(1,3,3);imshow(filtered_img);title('filtered image');
imwrite(filtered_img,'BUPT_gaussfilter_¦Ò=10.png','png');
end




