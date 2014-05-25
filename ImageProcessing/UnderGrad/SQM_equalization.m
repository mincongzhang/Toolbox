function BUPT_equalization(path)
%*****************************************************
% Image created by Beiling Lu
% Title:  BUPT_equalization
% Input Parameter: path of the pgm file
% Description: This file outputs the equalized histogram of a pgm image

% open the file in read mode
f= fopen(path,'r');
A = 0 ; % Ascii flag
% ignore the comments in the file
a = fscanf(f,'%s',1);
while(a(1)=='#')
    a = fscanf(f,'%s',1);
end

% check magic number
if ((strcmp(a,'P5')==0) &(strcmp(a,'P2')==0))
        while(a(1)=='#')
            a = fscanf(f,'%s',1);
        end    
         display('its not pgm file');
         
else
        display('its pgm file');
        if(strcmp(a,'P2'))
            A = 1;
        end
     	 a = fscanf(f,'%s',1);
        while(a(1) == '#')
            b = fgets(f);        % throw away the comments line
            a= fscanf(f,'%s',1); % read first character of next line
        end
            
            w = str2num(a);      % width of image
            a= fscanf(f,'%s',1);
            while(a(1) == '#')
                b = fgets(f);
                a= fscanf(f,'%s',1);
            end
                h = str2num(a);  % hight of image
                a= fscanf(f,'%s',1);                
             while(a(1) == '#')
                    b = fgets(f); % throw away the comments line
                    a= fscanf(f,'%s',1);
             end
                level = str2num(a); % colour levels
                               
            if (A == 1)               
                for i = 1:h
                    for j = 1:w
                        I(i,j) = fscanf(f,'%i',1); % Red
                        
                    end
                end
            else
                % Skip one more char
                fread(f,1);
                % Now read the matrix
                Arr = uint8(fread(f));
                index = 0;
                 for i = 1:1:h
                     for j = 1:w
                         index = index+1;
                         I(i,j) = Arr(index);                               
                     end
                 end
            end
            
            grey=zeros(1,256);                                        %initialize the frequency matrix of the original histogram
            for k=0:255
                grey(k+1)=length(find(I==k))/(w*h);                 %calculate the frequency of each grey scale level in the original histogram
            end
            figure,bar(0:255,grey,'g')                                     %draw original histogram
            title('original histogram')
            xlabel('grey scale level')
            ylabel('count')

            equal1=zeros(1,256);%initialize the frequency matrix of the equalized histogram
            for i=1:256
               for j=1:i
                   equal1(i)=grey(j)+equal1(i);           %calculate SK                   
               end
            end
            equal2=round(equal1*256);                                        %map SK to the nearest grey scale level
            for i=1:256
               greyEqual(i)=sum(grey(find(equal2==i)));                        %calculate the frequency of each grey scale level in the equalized histogram                
            end
            figure,bar(0:255,greyEqual,'b')                                    %draw the equalized histogram
            title('equalized histogram')
            xlabel('grey scale level')
          
            Iequal=imread(path);
            for i=0:255
                Iequal(find(I==i))=equal2(i+1);              
            end
            figure,imshow(Iequal)                           
            title('equalized image')
end




  
