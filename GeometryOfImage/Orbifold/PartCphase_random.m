clc
clear
close all

I = imread('n1.jpg');
I = rgb2gray(I);
% I = imread('tire.tif');
% I = imread('pout.tif');
% I = imread('forest.tif');
% I = 255-I;

[row col ~] = size(I);

%plot the phase and power of the suppressed image
FFT_G = fft2(double(I));
power = abs(fftshift(FFT_G));
origin_phase = angle(fftshift(FFT_G));
[f1,f2] = freqspace([row,col],'meshgrid');%get frequency space

%%
% phase-randomized
for m = 1:row
    for n = 1:col
        length = abs(FFT_G(m,n));
        rand_angle = rand(1)*2*pi;% random from (0,1)
        x = length*cos(rand_angle);
        y = length*sin(rand_angle);
        FFT_G(m,n) = x+1i*y;
    end
end

IFFT_G = ifft2(FFT_G);
IFFT_G = abs(IFFT_G);
IFFT_G = im2double(IFFT_G);
%%
kernel_length = 41;
sigma = 4; %control the size of the gaussian
DtG0 = DtG(0,kernel_length,sigma);
DtG1 = DtG(1,kernel_length,sigma);
DtG2 = DtG(2,kernel_length,sigma);

%%
%initial symmetry types
W1 = DtG2(:,:,1);
W2 = DtG2(:,:,2);
W3 = DtG2(:,:,3);
C00 = DtG0;
C00(:,end) = [];
C00(end,:) = [];
C10 = DtG1(:,:,1);
C10(:,end) = [];
C10(end,:) = [];
C01 = DtG1(:,:,2);
C01(:,end) = [];
C01(end,:) = [];
C20 = W2;
C02 = W2';
G11 = DtG(1,kernel_length,sigma);
C11 = G11(:,:,1).*G11(:,:,2);
C11(:,end) = [];
C11(end,:) = [];

%%
%convolve to image 
C00=conv2(IFFT_G,C00,'same');
C10=conv2(IFFT_G,C10,'same');
C01=conv2(IFFT_G,C01,'same');
C11=conv2(IFFT_G,C11,'same');
C20=conv2(IFFT_G,C20,'same');
C02=conv2(IFFT_G,C02,'same');

S00 = sigma^0*C00;
S10 = sigma^1*C10;
S01 = sigma^1*C01;
S11 = sigma^2*C11;
S20 = sigma^2*C20;
S02 = sigma^2*C02;
lambda = S20+S02;
gamma = sqrt((S20-S02).^2+4*S11.^2);
epsilon = 0.05;

M = zeros(size(C00,1),size(C00,2),7);
M(:,:,1) = epsilon*S00; %pink 255 153 204
M(:,:,2) = 2*sqrt(S10.^2 + S01.^2); %gray 150 150 150
M(:,:,3) = +lambda; %black 0 0 0
M(:,:,4) = -lambda; %white 255 255 255
M(:,:,5) = 2^(-1/2).*(lambda + gamma); %0 0 255
M(:,:,6) = 2^(-1/2).*(gamma - lambda); %yellow 255 255 0
M(:,:,7) = gamma; %green 0 255 0

Output = zeros(size(M,1),size(M,2),3);
for i = 1:size(M,1)
    for j = 1:size(M,2)
        idx = find(M(i,j,:)== max(M(i,j,:)));
        if idx == 1
            %255 153 204
            Output(i,j,1) = 255;
            Output(i,j,2) = 179;
            Output(i,j,3) = 178;
        end
        if idx == 2
            %255 153 204
            Output(i,j,1) = 150;
            Output(i,j,2) = 150;
            Output(i,j,3) = 150;
        end
        if idx == 3
            %255 153 204
            Output(i,j,1) = 0;
            Output(i,j,2) = 0;
            Output(i,j,3) = 0;
            
        end
        if idx == 4
            %255 153 204
            Output(i,j,1) = 255;
            Output(i,j,2) = 153;
            Output(i,j,3) = 204;
        end
        if idx == 5
            %255 153 204
            Output(i,j,1) = 0;
            Output(i,j,2) = 0;
            Output(i,j,3) = 255;
        end
        if idx == 6
            %255 153 204
            Output(i,j,1) = 255;
            Output(i,j,2) = 255;
            Output(i,j,3) = 0;
        end
        if idx == 7
            %255 153 204
            Output(i,j,1) = 0;
            Output(i,j,2) = 255;
            Output(i,j,3) = 0;
        end
    end
end
subplot(1,3,1),imshow(uint8(I));title({['Original Image'];[' ']});
subplot(1,3,2),imshow(uint8(IFFT_G));title({['Phase-randomized Version'];[' ']});
subplot(1,3,3),imshow(uint8(Output));title({['Basic Image Features'];['sigma=',num2str(sigma),' kernel size=',num2str(kernel_length)]});

