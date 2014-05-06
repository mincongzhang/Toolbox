function sub_sampling(path,ver,hor)
%BUPT_sub_sampling
%Mincong Zhang
%hor means sub sampling factor in the horizontal 
%ver means sub sampling factor in the vertical direction 
%e.g. h=2, v=2, means 2 horizontal, 2 vertical sub-sampling
%hor=1 or ver=1 means no sub sampling in the relevant direction 

[I,w,h,level]=pgmread(path);
I=double(I);
A=zeros(h,w);

%use my own choice of image
%I=imread(path)
%imwrite(I,'subsample_myoriginal.png','png');%for writing RGB image
%I=double(I);
%[h,w]=size(I);%for reading greylevel image
%[h,w,l]=size(I);%for reading RGB image
%A=zeros(h,w);

%change into greyscale image if [I,w,h,level]=ppmread(path);
%Y = 0.257*I(:,:,1)+0.504*I(:,:,2)+0.098*I(:,:,3) +16;

%sub-sampling from 1 to w with factor hor, 1 to h with factor ver
 A=I(1:ver:h,1:hor:w); %the size of the final image will shrink

%Convert to 8-bit unsigned integer
A=uint8(A);
imshow(A);
imwrite(A,'sub_sampling_Lena4ver4hor.png','png');
%imwrite(A,'subsample_mysub.png','png');%for writing RGB image

%write to the pgm file
%pgmwrite(I,w,h,level,1);% write in Ascii
%temp = {path};
%copyfile('outascii.pgm',['D:\matlab R2011a\bin\FUNCTION\Image processing\subsampling\','subsamp4ver4hor',temp{1,1}]);

end

