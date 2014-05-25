function  negative( path )
%BUPT_negative
%Mincong Zhang

%for pgm
%[I,w,h,level]=pgmread(path);
%for ppm
[I,w,h,level] = ppmread(path);
A=double(I);
%let the maximum grey level value minus the currrent grey level value
%so that to perform a negative calculation
A=255.-A;

A=uint8(A);
imshow(A);
end
