%Function:Simple Edge Detection
%Data:3rd Oct.,2008

clc;
clear all;
close all;

%%%%%%%%%%%%%%%%
%%%  Imread  %%%
%%%%%%%%%%%%%%%%
I0=imread('picturename.jpg');
I=rgb2gray(I0);
J0=double(I);
J_x=J0;
J_y=J0;
J=J0;
[M,N]=size(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Sobel Operator Filtering  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sobel_x=(1/4)*[-1,-2,-1;0,0,0;1,2,1];
Sobel_y=(1/4)*[-1,0,1;-2,0,2;-1,0,1];
[W_S,W_S]=size(Sobel_x);
Half_W_S=(W_S-1)/2;
%Filtering with Matrix Sobel_x to Get gx
for p=Half_W_S+1:M-Half_W_S   
    for q=Half_W_S+1:N-Half_W_S
        filter_sum=0;
        for k=-Half_W_S:Half_W_S
            for l=-Half_W_S:Half_W_S
                filter_sum=filter_sum+J0(p+k,q+l)*Sobel_x(k+Half_W_S+1,l+Half_W_S+1);
            end
        end
        J_x(p,q)=filter_sum;
    end
end
%Filtering with Matrix Sobel_y to Get gy
for p=Half_W_S+1:M-Half_W_S
    for q=Half_W_S+1:N-Half_W_S
        filter_sum=0;
        for k=-Half_W_S:Half_W_S
            for l=-Half_W_S:Half_W_S
                filter_sum=filter_sum+J0(p+k,q+l)*Sobel_y(k+Half_W_S+1,l+Half_W_S+1);
            end
        end
        J_y(p,q)=filter_sum;
    end
end
%J Indicates the Magnitude of the Gradient
J=(J_x.^2+J_y.^2).^(1/2);

%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Edge Detection  %%%
%%%%%%%%%%%%%%%%%%%%%%%%
%Choose a Appropriate T
Order_matrix=J(Half_W_S+1:M-Half_W_S,Half_W_S+1:N-Half_W_S);
[M_O,N_O]=size(Order_matrix);
Order_sequence0=[];
for i=1:M_O
    Order_sequence0=[Order_sequence0,Order_matrix(i,:)];
end
Order_sequence=sort(Order_sequence0);
T_location=round(0.95*M_O*N_O);
T=Order_sequence(1,T_location);
fprintf('\nT=%f\n',T);
%Saving the Result Edge Map
for m=1:M
    for n=1:N
        if J(m,n)>=T
            J(m,n)=255;
        else
            J(m,n)=0;
        end
    end
end
     
%%%%%%%%%%%%%%%%
%%%  Figure  %%%
%%%%%%%%%%%%%%%%
subplot(1,2,1);
imshow(uint8(I));title('Original Gray Image');
subplot(1,2,2);
imshow(uint8(J));title('Edge Detected Image');   