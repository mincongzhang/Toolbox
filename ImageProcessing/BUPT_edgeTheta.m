function  BUPT_edgeTheta()
%EDGE_DETECTION_IN_THETA
%in this function a Sobel kernal will be miltiplied by a rotation matrix
%so that to create an arbitrary angle rotated kernel 
%This kernel will lead to an edge detection in any angle
%Mincong Zhang

%Lena 30¡ã
A1=imread('Lena512_ASCII.pgm');
%Do the Sobel edge detection
BW1=Sobel_filter(A1,30);
figure,imshow(BW1);title('Lena 30¡ã')
imwrite(BW1,'Lena_Sobel30.png','png');

%Baboon 90¡ã
A2=imread('Baboon512_ASCII.pgm');
%Do the Sobel edge detection
BW2=Sobel_filter(A2,90);
figure,imshow(BW2);title('Baboon 90¡ã')
imwrite(BW2,'Baboon_Sobel90.png','png');

%Peppers 120¡ã
A3=imread('Peppers512_ASCII.pgm');
%Do the Sobel edge detection
BW3=Sobel_filter(A3,120);
figure,imshow(BW3);title('Peppers 120¡ã')
imwrite(BW3,'Peppers_Sobel120.png','png');

%Peppers 210¡ã
A4=imread('Peppers512_ASCII.pgm');
%Do the Sobel edge detection
BW4=Sobel_filter(A4,210);
figure,imshow(BW4);title('Peppers 210¡ã')
imwrite(BW4,'Peppers_Sobel210.png','png');
%%%%%%%%%%%%%%%%Sobel filter in theta%%%%%%%%%%%%%%%%%%%
function BW=Sobel_filter(input_img,angle)
        
I=im2double(input_img);%change the I matrix into double mode
%Sobel operator
x_mask=[-1 0 1; -2 0 2;-1 0 1];
y_mask=[1 2 1;0 0 0;-1 -2 -1];
x_rotated=BUPT_transform_rotate(x_mask,angle);
y_rotated=BUPT_transform_rotate(y_mask,angle);

dx=conv2(x_rotated,I);%calculate the gradient component in x coordinate.Although imfilter is more useful in N dimension,I used conv2 for clearence
dy=conv2(y_rotated,I);%calculate the gradient component in y coordinate
grad=sqrt(dx.*dx+dy.*dy);%calculate gradient

edge_img=mat2gray(grad);%change the gradient matrix into greyscale, The returned matrix I contains values in the range 0.0 (black) to 1.0 (full intensity or white). 
%imshow(gray_img) %we can see the edge in grey colour

%calculate the threshold of the grayscale
level=graythresh(edge_img);

%Convert image to binary image, based on threshold
BW=im2bw(edge_img,level);

end

%%%%%%%%%%%%THE FUNCTION "ROTATE"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rotated_matrix=BUPT_transform_rotate(I,angle)
%BUPT_transform_rotate
%Mincong Zhang
%I is the matrix
%angle is the angle for rotateing the image
%it return the rotated_matrix in double format
%rotate formulation
%x' = xcos¦È-ysin¦È
%y' = xsin¦È+ycos¦È

%[I,w,h,level]=pgmread(path);
R=double(I);
[w,h]=size(R);

%calculate the angle in ¦Ð mode
r=angle/180*pi;

x=1:w;
y=1:h;
[X,Y]=meshgrid(x,y);%transform into vector
xcolum=round(X*cos(r)-Y*sin(r));%calculate the colum vector for the new image
yrow=round(X*sin(r)+Y*cos(r));%calculate the row vector for the new image

%calculate the full size of the new image
xlength=max(max(xcolum))-min(min(xcolum));% maxmax return a row vector containing the maximum element, then return the max element
ylength=round(max(max(yrow))-min(min(yrow)));

%calculate the value of shift of the rotated image
shift_x=1-round(min(min(xcolum)));
shift_y=1-round(min(min(yrow)));

%create the new matrix
rotated_matrix=zeros(xlength,ylength);
for i=1:w
    for j=1:h
        a=round(i*cos(r)-j*sin(r))+shift_x;
        b=round(i*sin(r)+j*cos(r))+shift_y;
        rotated_matrix(a,b)=R(i,j);
    end
end
rotated_matrix=double(rotated_matrix);

end

end

