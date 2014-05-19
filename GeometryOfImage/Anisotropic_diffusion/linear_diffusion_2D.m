clc
clear 
close all
set(0,'defaultfigurecolor','w');

Img = imread('cameraman.tif');
Img = im2double(Img);
[row col] = size(Img);
N = row;
deltaT = 0.1;
iteration = 75;

%%
dd = zeros(N*N,3);
dd(:,1) =   1;
dd(:,2) =  -2;
dd(:,3) =   1;
Ax = spdiags(dd,-1:1,N*N,N*N);
Ay = spdiags(dd,[-N,0,N],N*N,N*N);
I  = speye(N*N);
fk = reshape(Img,N*N,1);

for i = 1:iteration
    %first half
    fk = reshape(fk,N*N,1);
    f_half = (I-deltaT/2.*Ax)\((I+deltaT/2.*Ay)*fk);
    
    %second half
    fk = (I-deltaT/2.*Ay)\((I+deltaT/2.*Ax)*f_half); %Ay = Ax here
    
    %output
    out = reshape(fk,N,N);
    imshow(out);title({['2D linear diffusion   ','Iteration: ',num2str(i),' deltaT: ',num2str(deltaT)]});
    hold on;

    %find local max
    MAX = max(out(:));
    [x y] = find(out == MAX);
    plot(y,x,'*');
    
    drawnow;
    %pause(1);

    %debug
    %plot(out(20,:));
    %set(gca, 'XLim', [0 N]);
    %set(gca, 'YLim', [0 1]);
    %drawnow;
end