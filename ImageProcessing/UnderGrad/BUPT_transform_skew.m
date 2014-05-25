function skewd_image=BUPT_transform_skew(I,angle)
%BUPT_transform_skew
%Mincong Zhang

%THE SECOND FUNCTION SKEW
%angle means the second angle for skewing the image 

%skew formulation
%x' = x+y/tan¦È
%y' = y

%[I,w,h,level]=pgmread(path);
A=double(I);
[w,h]=size(A);

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
for i=1:w
    for j=1:h
        a=i;
        b=round(-i/tan(s)+j)+shift_y; %the "-i/tan(s)" means to skew the image in a clockwise mode
        skewd_image(a,b)=A(i,j);
    end
end

skewd_image=uint8(skewd_image);
%imshow(skewd_image);

end

