
clc
clear
close all

I = imread('lena.bmp');
% I = imread('meerkat.jpg');
I = rgb2gray(I);
% imshow(I);
[row col ~] = size(I);
pattern = 2;
kernel_length = 21;
sigma = kernel_length/6; %control the size of the gaussian
gaussian_filter = DtG(pattern,kernel_length,sigma);
[m n dim] = size(gaussian_filter);

output = zeros(row,col);
% 
figure,
for d = 1:dim
    out(:,:,d) = conv2(im2double(I),gaussian_filter(:,:,d),'same');
    absout = abs(out(:,:,d));
    subplot(1,dim,d),imshow(absout./max(absout(:))); title(['Apply Kernel ' num2str(d)])
    %Gx^2+Gy^2
    output = output + out(:,:,d).^2; % avoid pixel value less than zero
end

%sqrt(Gx^2+Gy^2)
output = output.^(1/2); 

output = output./max(output(:));
figure,subplot(1,2,1),imshow(I); title('Original Image')
subplot(1,2,2),imshow(output);title('2nd Order Result')

