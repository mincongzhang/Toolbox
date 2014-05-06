function BUPT_format_converter(path)
%BUPT_format_converter
%Mincong Zhang

[I,w,h,level]=ppmread(path);%'Lena512C_ASCII.ppm'
I=double(I);

%show and write the RGB image
%I=uint8(I);
%imshow(I);
%imwrite(I,'LenaRGB.png','png');

%convert the RGB to YUV
Y = 0.257*I(:,:,1)+0.504*I(:,:,2)+0.098*I(:,:,3) +16;
U = -0.148*I(:,:,1)-0.291*I(:,:,2)+0.439*I(:,:,3) +128;
V = 0.439*I(:,:,1)-0.368*I(:,:,2)-0.071*I(:,:,3) +128;

%convert the YUV to RGB
     R = Y + 1.4075 *(V-128);
     G = Y - 0.3455 *(U -128) - 0.7169 *(V -128);
     B = Y + 1.779 *(U - 128);
          

%show the Y component(grey scale)
Y=uint8(Y);
figure,imshow(Y);
imwrite(Y,'LenaGREY.png','png');

%show the YUV 3 channel image
       for i = 1:h
           for j = 1:w
               M(i,j,1) = Y(i,j); % luminance
               M(i,j,2) = U(i,j); % chrominance
               M(i,j,3) = V(i,j); % chrominance
               N(i,j,1) = R(i,j); % R
               N(i,j,2) = G(i,j); % G
               N(i,j,3) = B(i,j); % B
           end
       end
       
      M=uint8(M);
      figure,imshow(M);
      imwrite(M,'LenaYUV.png','png');   %YUV
      
      N=uint8(N);
     figure,imshow(N);
     imwrite(N,'LenaYUV2RGB.png','png');   %RGB
      
      
end
