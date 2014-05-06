function histeq(I)
%BUPT_historgram equalization
%generate the histogram Ha(Da) of A
[h,w]=size(I);
his=histro(I);
cumsum=zeros(1,256);%cumulative histogram
imeq=zeros(h,w);
cumsum(1)=his(1);
for i=2:256
    cumsum(i)=his(i)+cumsum(i-1);%for each input gray level Da compute the cumulative sum
end
histeq=round(cumsum*255/(h*w));%for each Da scale sum by Dm/A0
for m=1:h
    for n=1:w
        gval=I(m,n)+1;
        imeq(m,n)=histeq(gval);%replace each grey level
    end
end

imeq=uint8(imeq);
histeq=BUPT_hist(imeq);
figure,imshow(imeq);