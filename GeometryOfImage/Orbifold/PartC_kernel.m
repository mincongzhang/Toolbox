clc
clear
close all


kernel_length = 255;
sigma = kernel_length/6; 
DtG0 = DtG(0,kernel_length,sigma);
DtG1 = DtG(1,kernel_length,sigma);
DtG2 = DtG(2,kernel_length,sigma);

%%
%initial symmetry types
W2 = DtG2(:,:,2);
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
M(:,:,1) = epsilon*S00; 
M(:,:,2) = 2*sqrt(S10.^2 + S01.^2); 
M(:,:,3) = +lambda;
M(:,:,4) = -lambda; 
M(:,:,5) = 2^(-1/2).*(lambda + gamma); 
M(:,:,6) = 2^(-1/2).*(gamma - lambda); 
M(:,:,7) = gamma; 
M(:,end,6) = 0.00000001; 
M(end,:,6) = 0.00000001; 
M(:,end,7) = 0.00000001; 
M(end,:,7) = 0.00000001; 

for i = 1:7
    M1 = M(:,:,i);
    M1 = M1./max(M1(:));
    subplot(1,7,i),imshow(M1);
end
