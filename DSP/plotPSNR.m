function  plotPSNR
S=zeros(1,100);
  for f=1:100
    S(f)=DSP_Bartworth(1,f,0.01); %阶数n=1，噪声强度noise=0.01
  end
figure,plot(S);%画出PSNR值分布
title('PSNR分布图');xlabel('截止频率d0');ylabel('PSNR值')
M = max( S ) %在所有PSNR值中找到最大值
find(S==M)%得出最大PSNR对应的截止频率d0

