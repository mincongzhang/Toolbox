function modelling()
A=imread('Peppers512_ASCII.pgm'); 
figure,imshow(A);
[m,n]=size(A); 
B=zeros(1,256); %B is the histrogram of A
for k=0:255
B(k+1)=length(find(A==k)); %calculate the freq
end
figure,bar(0:255,B,'b'); %draw histrogram

S1=zeros(1,256);
for i=1:256%S1=B;
for j=1:i%S1(1)=B(1);
S1(i)=B(j)+S1(i); %for i=2:256
%       cumsum(i)=his(i)+cumsum(i-1);%for each input gray level Da compute the cumulative sum
%       end
end
end



S3=zeros(1,256);
for i=1:150
S3(i+80)=B(i);
end
S4=zeros(1,256);
for i=81:230
S4(i)=B(i)+S3(i);
end
counts=S4;%indicated histrogram



S2=zeros(1,256);
for i=1:256
for j=1:i
S2(i)=counts(j)+S2(i); 
end
end; %"cumulate


%compare and find the least greylevel
S=zeros(256,256);
for i=1:256
for j=1:256
S(j,i)=abs(S2(j)-S1(i));%the difference between each pixel
end
end 
[Y,T]=min(S);


%Reorganized the histrogram
for j=1:256

H(j)=sum(B(find(T==j)));

end
figure,bar(0:255,H,'b') %show the modelling hist
title('modelling hist')
xlabel('grey-level')
ylabel('freq')
axis([0,260,0,0.03])

%show the modelling hist
PA=A;
for i=0:255
PA(find(A==i))=T(i+1); 
end
figure,imshow(PA) 
title('modelling image')
end