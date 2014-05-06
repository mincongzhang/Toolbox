function  BUPT_transform(path,rotate,skew)
%BUPT_TRANSFORM 
%Zhang Mincong
%this function will rotate the input matrix with an angle 'rotate', and skew the input maritx with an angle 'skew' 
%combine the FIRST FUNCTION ROTATE and the SECOND FUNCTION SKEW
%[I,w,h,level]=pgmread(path);
I=imread(path);
%seperated image
rotated_image=BUPT_transform_rotate(I,rotate);
skewd_image=BUPT_transform_skew(I,skew);

%combined image
%rotated_skewd_image=BUPT_transform_skew(rotated_image,skew);
skewd_rotated_image=BUPT_transform_rotate(skewd_image,rotate);

figure,imshow(rotated_image);
imwrite(rotated_image,'rotated20.png','png');

figure,imshow(skewd_image);
imwrite(skewd_image,'skewd50.png','png');

%figure,imshow(rotated_skewd_image);
%imwrite(rotated_skewd_image,'rotated_skewdMINCONG ZHANG.png','png');
figure,imshow(skewd_rotated_image);
imwrite(skewd_rotated_image,'skewd_rotatedMINCONG ZHANG.png','png');

subplot(1,3,1), imshow(rotated_image);
subplot(1,3,2), imshow(skewd_image);
%subplot(1,3,3), imshow(rotated_skewd_image);
subplot(1,3,3), imshow(skewd_rotated_image);
end

%%%%%%%%%%%%THE FIRST FUNCTION "ROTATE"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rotated_image=BUPT_transform_rotate(I,angle)
%BUPT_transform_rotate
%Mincong Zhang
%I is the matrix of the image
%angle is the angle for rotateing the image

%rotate formulation
%x' = xcos¦È-ysin¦È
%y' = xsin¦È+ycos¦È

%[I,w,h,level]=pgmread(path);
A=double(I);
[w,h]=size(A);

%calculate the angle in ¦Ð mode
r=-angle/180*pi;

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
rotated_image=zeros(xlength,ylength);
for i=1:w
    for j=1:h
        a=round(i*cos(r)-j*sin(r))+shift_x;
        b=round(i*sin(r)+j*cos(r))+shift_y;
        rotated_image(a,b)=A(i,j);
    end
end

%fulfill the hole in the image
for i=1:xlength
    flag=0;
    for j=1:ylength-1
        if rotated_image(i,j)~=0
            flag=1;
        end
        if rotated_image(i,j)==0 & flag==1
        rotated_image(i,j)=rotated_image(i,j+1);
        end
    end
end
rotated_image=uint8(rotated_image);
%imshow(rotated_image);

end


%%%%%%%%%%%%%%%%%%THE SECOND FUNCTION "SKEW"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function skewd_image=BUPT_transform_skew(I,angle)
%BUPT_transform_skew
%Mincong Zhang


%angle means the second angle for skewing the image 

%skew formulation
%x' = x+y/tan¦È
%y' = y

%[I,w,h,level]=pgmread(path);
A=double(I);
[h,w]=size(A);

%calculate the angle in ¦Ð mode
s=(90-angle)/180*pi;

x=1:w;
y=1:h;
[X,Y]=meshgrid(x,y);%transform into vector
%calculate the colum vector for the new image
xcolum=X;
%calculate the row vector for the new image
yrow=round(-X/tan(s)+Y); %the "-X/tan(s)" means to skew the image in a clockwise mode
                       

%calculate the full size of the new image
xlength=max(max(xcolum))-min(min(xcolum));% maxmax return a row vector containing the maximum element then return the max element
ylength=round(max(max(yrow))-min(min(yrow)));

%calculate the value of shift of the rotated image
shift_y=1-round(min(min(yrow)));

%create the new matrix
skewd_image=zeros(xlength,ylength);
for i=1:h
    for j=1:w
        a=i;
        b=round(-i/tan(s)+j)+shift_y; %the "-i/tan(s)" means to skew the image in a clockwise mode
        skewd_image(a,b)=A(i,j);
    end
end

skewd_image=uint8(skewd_image);
%imshow(skewd_image);

end