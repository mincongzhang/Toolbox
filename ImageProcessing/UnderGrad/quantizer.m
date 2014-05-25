function quantizer(path,factor)
%BUPT_quantization
%Mincong Zhang
%This function simply divide the greyscale with the factor,and use floor to get an approximate greylevel
%Then multiply the factor back to max 255 greyscale
%So that to achieve the function of quantization

[I,w,h,level]=pgmread(path);
I=double(I);

A=floor(I./factor);
A=A.*factor;%convert into max 255 greyscale

  %write back to PGM/PPM files
  I=A;
  
  %write to the pgm file
 temp = {path};
  %ASCII
  pgmwrite(I,w,h,level,1);% mode ==1 write in Ascii;mode ==1 write in binary
  copyfile('outascii.pgm',['C:\MATLAB6p5p1\work\quantization_write_back\','AAAwriteback',temp{1,1}]);


%Convert to 8-bit unsigned integer
%A=uint8(A);
%imshow(A);
%imwrite(A,'Quantized_Peppers128.png','png');


end

