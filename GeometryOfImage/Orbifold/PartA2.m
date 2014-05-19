clc
clear
close all

I = imread('n3.jpg');
I = rgb2gray(I);
% I = imread('tire.tif');
% I = imread('pout.tif');
% I = imread('forest.tif');


[row col ~] = size(I);

%plot the phase and power of the suppressed image
FFT_G = fft2(double(I));
power = abs(fftshift(FFT_G));
origin_phase = angle(fftshift(FFT_G));
[f1,f2] = freqspace([row,col],'meshgrid');%get frequency space
subplot(2,2,1);mesh(f1,f2,log(power+1));title('Original Power Spectrum');
subplot(2,2,3);imagesc(origin_phase);title('Original Phase Spectrum');

%%
% % phase-randomized
% for m = 1:row
%     for n = 1:col
%         length = abs(FFT_G(m,n));
%         rand_angle = rand(1)*2*pi;% random from (0,1)
%         x = length*cos(rand_angle);
%         y = length*sin(rand_angle);
%         FFT_G(m,n) = x+1i*y;
%     end
% end
% 
% IFFT_G = ifft2(FFT_G);
% IFFT_G = abs(IFFT_G);
% subplot(1,2,2),imshow(uint8(IFFT_G));title('Phase-randomized Version');
% 
% %plot the phase and power of the suppressed image
% power = abs(fftshift(FFT_G));
% phase = angle(fftshift(FFT_G));
% [f1,f2] = freqspace([row,col],'meshgrid');%get frequency space
% % subplot(2,2,2);mesh(f1,f2,log(power+1));title('Phase-randomized Power Spectrum');
% % subplot(2,2,4);imagesc(phase);title('Phase-randomized Phase Spectrum');


%%
%whitened method
Iorigin = I;
FFT_G = fft2(double(I));
% mean_power = sqrt(mean(abs(FFT_G(:)).^2));
mean_power = (mean(abs(FFT_G(:)).^2));

%normalize frequencies in every column and row
for m = 1:row
    FFT_G(m,:) = FFT_G(m,:)/mean(abs(FFT_G(m,:)));
end

for n = 1:col
    FFT_G(:,n) = FFT_G(:,n)/mean(abs(FFT_G(:,n)));
end

%normalize and add some intensity to make it white
IFFT_G = ifft2(FFT_G);
IFFT_G = IFFT_G./max(IFFT_G(:));
IFFT_G = IFFT_G+0.8;

%plot the phase and power of the suppressed image
FFT_G = fft2(double(IFFT_G));
power = abs(fftshift(FFT_G));
phase = angle(fftshift(FFT_G));
[f1,f2] = freqspace([row,col],'meshgrid');%get frequency space
subplot(2,2,2);mesh(f1,f2,log(power+1));title('Power Spectrum');
% subplot(2,2,2);imagesc(log(power+1));title('Power Spectrum');
subplot(2,2,4);imagesc(phase);title('Phase Spectrum');

figure,subplot(1,2,1); imshow(Iorigin);title('Original Image')
subplot(1,2,2);imshow(abs(IFFT_G)); title('Whitened Version');
diff = origin_phase - phase;
max(diff(:))