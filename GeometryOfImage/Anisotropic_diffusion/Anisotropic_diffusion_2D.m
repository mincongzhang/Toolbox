clc
clear 
close all
set(0,'defaultfigurecolor','w');

I = imread('cameraman.tif');
I = im2double(I);
[row col] = size(I);
N = row;
deltaT = 0.1;
n = 110;

[gx,gy] = gradient(I);
img_gradiance = sqrt(gx.^2+gy.^2);
T = max(img_gradiance(:))/2; %threshold

%kap
kappa = 1./(1+(img_gradiance./T).^2);
kap = spdiags(reshape(kappa,[],1),0:0,N*N,N*N);
%Dx
dx = zeros(N*N,2);
dx(:,1) =  1;
dx(:,2) = -1;
Dx = spdiags(dx,0:1,N*N,N*N);
%Dy
dy = zeros(N*N,2);
dy(:,1) =  1;
dy(:,2) = -1;
Dy = spdiags(dy,[0,N],N*N,N*N);

%PM
PM = -(Dx'*kap*Dx + Dy'*kap*Dy);

%Iteration
figure,
for i = 1:n   
   I = reshape(I,[],1);
   I = I + deltaT*PM*I;
   I = reshape(I,N,N);
   imshow(I); title({['2D Anisotropic diffusion'],['Iteration: ',num2str(i),' deltaT: ',num2str(deltaT),' threshold ',num2str(T)]});
   hold on;
   
   MAX = max(I(:));
   [x y] = find(I == MAX);
   plot(y,x,'*');
   drawnow;
   
%    %debug
%    %PROBLEM, gradiance in y axis cannot preserve sharp edge
%    subplot(1,2,1),plot(I(120,:));title('x axis');
%    set(gca, 'XLim', [0 N]);
%    set(gca, 'YLim', [0 1]);
%    subplot(1,2,2),plot(I(:,120));title('y axis');
%    set(gca, 'XLim', [0 N]);
%    set(gca, 'YLim', [0 1]);
%    drawnow;
end