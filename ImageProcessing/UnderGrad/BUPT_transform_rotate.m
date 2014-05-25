function rotated_image=BUPT_transform_rotate(I,angle)
%BUPT_transform_rotate
%Mincong Zhang

%THE FIRST FUNCTION ROTATE
%angle means the angle for rotateing the image

%rotate formulation
%x' = xcos¦È-ysin¦È
%y' = xsin¦È+ycos¦È

%[I,w,h,level]=pgmread(path);
A=double(I);
[w,h]=size(A);

%calculate the angle in ¦Ð mode
r=angle/180*pi;

x=1:w;
y=1:h;
[X,Y]=meshgrid(x,y);%transform into vector
xcolum=round(X*cos(r)-Y*sin(r));%calculate the colum vector for the new image
yrow=round(X*sin(r)+Y*cos(r));%calculate the row vector for the new image

%calculate the full size of the new image
xlength=max(max(xcolum))-min(min(xcolum));% maxmax return a row vector containing the maximum elementthen return the max element
ylength=round(max(max(yrow))-min(min(yrow)));

%calculate the value of shift of the rotated image
shift_x=1-round(min(min(xcolum)));
shift_y=1-round(min(min(yrow)));

%create the new matrix
rotated_image=ones(xlength,ylength)*255;
for i=1:w
    for j=1:h
        a=round(i*cos(r)-j*sin(r))+shift_x;
        b=round(i*sin(r)+j*cos(r))+shift_y;
        rotated_image(a,b)=A(i,j);
    end
end


rotated_image=uint8(rotated_image);
imshow(rotated_image);

end

