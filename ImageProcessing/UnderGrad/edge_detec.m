function edge_detec()
%EDGE_DETECTION
%Mincong Zhang

%GREY IMAGE
%In this function I used three edge detector to figure out the edge of Lena
%I used a main function in advance, then call three edge detectors respectively.

%COLOUR IMAGE
%In this function I used three edge detector 
%to figure out the edge of Lena in RGB colour space.
%I used a main function in advance, then call three edge detectors respectively.

%%%CAUTION%%%
% In COLOUR IMAGE, I transform the RGB colour image into YUV colour space
% The reason is that I think only convolve the edge-detect operator with
% R,G,B three layers would not work. The output will distorted and would
% not show the colour in a appropriate way.
% Therefore I convert the RGB into YUV and use edge detector to figure out
% the edge in Y component, which is thought to be the luminance(grey
% level). And join the edged Y component with UV (chrominance) to show the
% edge of colour image

%GREY IMAGE
A=imread('Lena512_ASCII.pgm');

%(1)Do the Sobel edge detection
BW1=Sobel_filter(A);
subplot(2,3,1),imshow(BW1);title('Sobel')
imwrite(BW1,'Lena_Sobel_gray.png','png');

%(2)Do the Roberts edge detection
BW2=Roberts_filter(A);
subplot(2,3,2),imshow(BW2);title('Roberts')
imwrite(BW2,'Lena_Roberts_gray.png','png');

%(3)Do the Prewitt edge detection
BW3=Sobel_filter(A);
subplot(2,3,3),imshow(BW3);title('Prewitt')
imwrite(BW3,'Lena_Prewitt_gray.png','png');

%%%%%%%%%%%%%%%%RGB COLOUR IMAGE%%%%%%%%%%%%%%%%%%%%%%%%
[Colour_img,w,h,l]=ppmread('Peppers512C_ASCII.ppm');%'Peppers512C_ASCII.ppm'
Colour_img=double(Colour_img);

Y = 0.257*Colour_img(:,:,1)+0.504*Colour_img(:,:,2)+0.098*Colour_img(:,:,3) +16;
U = -0.148*Colour_img(:,:,1)-0.291*Colour_img(:,:,2)+0.439*Colour_img(:,:,3) +128;
V = 0.439*Colour_img(:,:,1)-0.368*Colour_img(:,:,2)-0.071*Colour_img(:,:,3) +128;

%(4)Do the Sobel edge detection
Y_sobel=Sobel_filter(Y);
%because I used conv2,the outcome dimension is M+N-1(514*514). (conv2(,,'same')can also solve this problem)
%Also the outcome is greylevel intensity(0:1),I need to *255
Y_sobel=double(Y_sobel(2:513,2:513))*255;

%convert the YUV to RGB
     R = Y_sobel + 1.4075 *(V-128);
     G = Y_sobel - 0.3455 *(U -128) - 0.7169 *(V -128);
     B = Y_sobel + 1.779 *(U - 128);
       for i = 1:h
           for j = 1:w
               BW4(i,j,1) = R(i,j); % R
               BW4(i,j,2) = G(i,j); % G
               BW4(i,j,3) = B(i,j); % B
           end
       end
      BW4=uint8(BW4);
subplot(2,3,4),imshow(BW4);title('Sobel_ RGB')
imwrite(BW4,'Peppers_Sobel_RGB.png','png');

%(5)Do the Roberts edge detection
Y_Roberts=Roberts_filter(Y);
%because I used conv2,the outcome dimension is M+N-1(514*514). (conv2(,,'same')can also solve this problem)
%Also the outcome is greylevel intensity(0:1),I need to *255
Y_Roberts=double(Y_Roberts(2:513,2:513))*255;

%convert the YUV to RGB
     R = Y_Roberts + 1.4075 *(V-128);
     G = Y_Roberts - 0.3455 *(U -128) - 0.7169 *(V -128);
     B = Y_Roberts + 1.779 *(U - 128);
       for i = 1:h
           for j = 1:w
               BW5(i,j,1) = R(i,j); % R
               BW5(i,j,2) = G(i,j); % G
               BW5(i,j,3) = B(i,j); % B
           end
       end
      BW5=uint8(BW5);
subplot(2,3,5),imshow(BW5);title('Roberts_ RGB')
imwrite(BW5,'Peppers_Roberts_RGB.png','png');

%(6)Do the Prewitt edge detection
Y_Prewitt=Prewitt_filter(Y);
%because I used conv2,the outcome dimension is M+N-1(514*514). (conv2(,,'same')can also solve this problem)
%Also the outcome is greylevel intensity(0:1),I need to *255
Y_Prewitt=double(Y_Prewitt(2:513,2:513))*255;

%convert the YUV to RGB
     R = Y_Prewitt + 1.4075 *(V-128);
     G = Y_Prewitt - 0.3455 *(U -128) - 0.7169 *(V -128);
     B = Y_Prewitt + 1.779 *(U - 128);
       for i = 1:h
           for j = 1:w
               BW6(i,j,1) = R(i,j); % R
               BW6(i,j,2) = G(i,j); % G
               BW6(i,j,3) = B(i,j); % B
           end
       end
      BW6=uint8(BW6);
subplot(2,3,6),imshow(BW6);title('Prewitt_ RGB')
imwrite(BW6,'Peppers_Prewitt_RGB.png','png');

%%%%%%%%%%%%%%%%Sobel filter%%%%%%%%%%%%%%%%%%%
function BW=Sobel_filter(input_img)
        
I=im2double(input_img);%change the I matrix into double mode
%Sobel operator
x_mask=[-1 0 1; -2 0 2;-1 0 1];
y_mask=[1 2 1;0 0 0;-1 -2 -1];

dx=conv2(x_mask,I);%calculate the gradient component in x coordinate.
dy=conv2(y_mask,I);%calculate the gradient component in y coordinate
grad=sqrt(dx.*dx+dy.*dy);%calculate gradient

edge_img=mat2gray(grad);%change the gradient matrix into greyscale, The returned matrix I contains values in the range 0.0 (black) to 1.0 (full intensity or white). 
%imshow(gray_img) %we can see the edge in grey colour

%calculate the threshold of the grayscale
level=graythresh(edge_img);

%Convert image to binary image, based on threshold
BW=im2bw(edge_img,level);

end

%%%%%%%%%%%%%Roberts filter%%%%%%%%%%%%%%%%
function BW=Roberts_filter(input_img)
        
I=im2double(input_img);%change the I matrix into double mode
%Roberts operator
x_mask=[1,0;0,-1];
y_mask=[0,-1;1,0];

dx=conv2(x_mask,I);%calculate the gradient component in x coordinate
dy=conv2(y_mask,I);%calculate the gradient component in y coordinate
grad=sqrt(dx.*dx+dy.*dy);%calculate gradient

edge_img=mat2gray(grad);%change the gradient matrix into greyscale, The returned matrix I contains values in the range 0.0 (black) to 1.0 (full intensity or white). 
%imshow(gray_img) %we can see the edge in grey colour

%calculate the threshold of the grayscale
level=graythresh(edge_img);

%Convert image to binary image, based on threshold
BW=im2bw(edge_img,level);

end

%%%%%%%%%%%%%Prewitt filter%%%%%%%%%%%%%%%%
function BW=Prewitt_filter(input_img)
        
I=im2double(input_img);%change the I matrix into double mode
%Prewitt operator
x_mask=[1,1,1; 0,0,0;-1,-1,-1];
y_mask=[-1,0,1;-1,0,1;-1,0,1];

dx=conv2(x_mask,I);%calculate the gradient component in x coordinate
dy=conv2(y_mask,I);%calculate the gradient component in y coordinate
grad=sqrt(dx.*dx+dy.*dy);%calculate gradient

edge_img=mat2gray(grad);%change the gradient matrix into greyscale, The returned matrix I contains values in the range 0.0 (black) to 1.0 (full intensity or white). 
%imshow(gray_img) %we can see the edge in grey colour

%calculate the threshold of the grayscale
level=graythresh(edge_img);

%Convert image to binary image, based on threshold
BW=im2bw(edge_img,level);

end

end

