function  equal( path )
%BUPT_equalization
%Mincong Zhang
[I,w,h,level]=pgmread(path);
A=double(I);
A=uint8(A);
%easier and quicker way to read
%A=pgmread(path);  

%original image
[A_counts, A_x] = imhist(A);

%after equalization
A_eq = histeq(A);
[A_eq_counts, A_eq_x] = imhist(A_eq);

%calculate cumulative
A_c = cumsum(A_counts);
A_eq_c = cumsum(A_eq_counts);

%show images
figure,imhist(A_eq);
figure,
subplot(2,3,1),imshow(A);
subplot(2,3,2), imhist(A);
subplot(2,3,3), plot(A_c);

subplot(2,3,4),imshow(A_eq);
imwrite(A_eq,'Mon equalized.png','png');
subplot(2,3,5), imhist(A_eq);

subplot(2,3,6), plot(A_eq_c);
end

