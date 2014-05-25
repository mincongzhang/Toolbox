function  histo( path )
%BUPT_histograms
%Mincong Zhang
%This function calculate the histrogram of an input image

A=imread(path);
%create an empty histrogram vector
histro = zeros(1,256);
%filling the relevant grey level into the histrogram
for i = 1:256
    histro(i) = length(find(A==(i-1)));
end
figure,bar(histro);
axis([0 255 0 max(histro)*1.1]);
end

