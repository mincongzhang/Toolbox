clc
clear
close all

% I = imread('board.tif');
% I = imread('fabric.png');
I = imread('office_5.jpg');
I = rgb2gray(I);
I = im2double(I);

kernel_length = 41;
sigma = 4; 
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
C00=conv2(I,C00,'same');
C10=conv2(I,C10,'same');
C01=conv2(I,C01,'same');
C11=conv2(I,C11,'same');
C20=conv2(I,C20,'same');
C02=conv2(I,C02,'same');

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

Output = zeros(size(M,1),size(M,2),3);
for i = 1:size(M,1)
    for j = 1:size(M,2)
        colour = find(M(i,j,:)== max(M(i,j,:)));
        switch colour
            case 1
            %pink
            Output(i,j,1) = 255;
            Output(i,j,2) = 179;
            Output(i,j,3) = 178;
            case 2
            %grey
            Output(i,j,1) = 150;
            Output(i,j,2) = 150;
            Output(i,j,3) = 150;
            case 3
            %black
            Output(i,j,1) = 0;
            Output(i,j,2) = 0;
            Output(i,j,3) = 0;
            case 4
            %white
            Output(i,j,1) = 255;
            Output(i,j,2) = 255;
            Output(i,j,3) = 255;
            case 5
            %blue
            Output(i,j,1) = 0;
            Output(i,j,2) = 0;
            Output(i,j,3) = 255;
            case 6
            %yellow 
            Output(i,j,1) = 255;
            Output(i,j,2) = 255;
            Output(i,j,3) = 0;
            case 7
            %green
            Output(i,j,1) = 0;
            Output(i,j,2) = 255;
            Output(i,j,3) = 0;
        end
    end
end
subplot(1,2,1),imshow(I);title({['Original Image'];[' ']});
subplot(1,2,2),imshow(uint8(Output));title({['Basic Image Features'];['sigma=',num2str(sigma),' kernel size=',num2str(kernel_length)]});