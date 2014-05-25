function ppmwrite(I,w,h,l,mode)
%*****************************************************
% Title:  QMUL_pgmwrite
% Input Parameters: 
%                I: Matrix to write in pgm
%            (w,h): dimension of matrix
%                l: gray levels
%             mode: ASCII or Binary (1 for Ascii and 0 for Binary)
% Description: This file stores input matrix into a .ppm file

% open the file in write mode
if (strcmp(mode,'P3')) ; % Ascii flag
    f= fopen('outascii.ppm','w');
    fprintf(f,'P3\n');
    fprintf(f,'#outascii.ppm\n');
    fprintf(f,'#image created by Mincong Zhang');
    fprintf(f,'\n# image width\n');
    fprintf(f,'%i',w);
    fprintf(f,'\n# image height\n');
    fprintf(f,'%i',h);
    fprintf(f,'\n# image height\n');
    fprintf(f,'%i',l);    
    fprintf(f,'\n');
    
    for i=1:w      
        for j=1:h
            fprintf(f,' %s ',num2str(I(i,j,1)),num2str(I(i,j,2)),num2str(I(i,j,3)));            
        end
            fprintf(f,'\n');
    end    
  
elseif (strcmp(mode,'P6'))
    f= fopen('outbinary.ppm','w');
    fprintf(f,'P6\n');
    fprintf(f,'#outbinary.ppm\n');
    fprintf(f,'#image created by Mincong Zhang');
    fprintf(f,'\n# image width\n');
    fprintf(f,'%i',w);
    fprintf(f,'\n# image height\n');
    fprintf(f,'%i',h);
    fprintf(f,'\n# image height\n');
    fprintf(f,'%i',l);    
    fprintf(f,'\n');
    
    for i=1:w      
        for j=1:h
            fprintf(f,'%c',I(i,j,1),I(i,j,2),I(i,j,3));                    
        end
    end    
  
end
