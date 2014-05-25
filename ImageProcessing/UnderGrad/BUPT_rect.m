function BUPT_rect(size)
%BUPT_rect 
%Mincong Zhang

path='Lena512_ASCII.pgm';                
[I,w,h,level]=pgmread(path);
original_img=uint8(I);%change into binary to do the imnoise

%noise=input('input the noise power:');%input the noise power
noise=0.5;%lab required
noised_img=imnoise(original_img,'gaussian',0,noise);
noised_img=double(noised_img);

%rect filter
kernel=1/(size^2)*(ones(size,size));
R=conv2(noised_img,kernel);
R=uint8(R);
figure,imshow(R);
imwrite(R,'BUPT_rect_size7.png','png');
end