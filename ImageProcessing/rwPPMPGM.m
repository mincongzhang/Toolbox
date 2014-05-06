function rwPPMPGM(path,type)
%BUPT_rwPPMPGM
%Mincong Zhang
%This function will read and write PPM and PGM images.
%set type==1 means image read is ppm
%set type==3 means image read is pgm
%header image created by Mincong Zhang

if (type==1)
  %read ppm
  [I,w,h,level] = ppmread(path);
  temp = {path};% record the name of the file
  %write to the ppm file
  
  %ASCII
  %ppmwrite(I,w,h,level,'P3');% write in Ascii
  %copyfile('outascii.ppm',['C:\MATLAB6p5p1\work\writing\','ZMCcreated',temp{1,1}]);
  
  %Binary
  ppmwrite(I,w,h,level,'P6');% write in Binary
  copyfile('outbinary.ppm',['C:\MATLAB6p5p1\work\writing\','ZMCcreated',temp{1,1}]);
  
  else if (type==2)
  %read pgm
  [I,w,h,level] = pgmread(path);
 
  %write to the pgm file
 temp = {path};
  %ASCII
  %pgmwrite(I,w,h,level,1);% mode ==1 write in Ascii
  %copyfile('outascii.pgm',['C:\MATLAB6p5p1\work\writing\','ZMCcreated',temp{1,1}]);
  
  %Binary
  pgmwrite(I,w,h,level,0);% mode ==0 write in Binary
  copyfile('outbinary.pgm',['C:\MATLAB6p5p1\work\writing\','ZMCcreated',temp{1,1}]);
end

end



