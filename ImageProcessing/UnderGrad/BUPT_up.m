function BUPT_up(path,ver,hor)
%BUPT_up_sampling
%Mincong Zhang
%hor means up sampling factor in the horizontal 
%ver means up sampling factor in the vertical direction 
%e.g. h=2, v=2, means 2 horizontal, 2 vertical up-sampling
%hor=0 or ver=0 means no up sampling in the relevant direction 

[I,w,h,level]=pgmread(path);
I=double(I);
H=ceil(h*ver);
W=ceil(w*hor);

%%%%%%%%%%%%%%%(1)NEAREST NEGHBOUR INTERPOLATION%%%%%%%%%%%%%%%%%%%%%%%%%%%
%up-sampling from 1 to h with factor hor, 1 to w with factor ver
A=zeros(H,W);
for (i =1:H)%vertical
    for (j =1:W)%horizontal
    a=ceil(i./ver); %mapping the coordinate in original small image to the bigger image
    b=ceil(j./hor); %mapping the coordinate in original small image to the bigger image
    
    %in case that the sampled coordinates exceed the original coordinates
        if (a>h)
           a=h;
        end
        if (b>w)
           b=w;
        end
     %nearst neighbour greylevel assign to the new image   
        A(i,j)=I(a,b);
    end
end

%Convert to 8-bit unsigned integer
%A=uint8(A);
%figure,imshow(A);
%imwrite(A,'BUPT_up_Lena.png','png');

%%%%%%%%%%%%%%%%%%%%%%(2)BILINEAR INTERPOLATION%%%%%%%%%%%%%%%%%%%%%%%%%%%
%up-sampling from 1 to h with factor hor, 1 to w with factor ver

B=zeros(H,W);
for (i =1:H)%vertical
    for (j =1:W)%horizontal
    x=i./ver;    
    y=j./hor;    
    X=ceil(x); %mapping the coordinate in original small image to the bigger image
    Y=ceil(y); %mapping the coordinate in original small image to the bigger image
    
    %in case that the sampled coordinates exceed the original coordinates
        if (X>h-1)% in case that in bi-linear interpolation the f11 would exceed the coordinate eg.f01=I(X,Y+1) == I(:,513)
           X=h-1;
        end
        if (Y>w-1)
           Y=w-1;
        end

    %bi-linear interpolate
        if((X/x==1)&&(Y/y==1))
            B(i,j)=I(X,Y);
        else
            f00=I(X,Y);   f01=I(X,Y+1);
            f10=I(X+1,Y); f11=I(X+1,Y+1);
        B(i,j)= (Y+1-y) * ((x-X)*f10 + (X+1-x)*f00) + (y-Y) * ((x-X)*f11 +(X+1-x) * f01);
        end
    end
end

%Convert to 8-bit unsigned integer
B=uint8(B);
imshow(B);
imwrite(B,'BUPT_up_Baboon.png','png');
end

