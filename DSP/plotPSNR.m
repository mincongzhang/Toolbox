function  plotPSNR
S=zeros(1,100);
  for f=1:100
    S(f)=DSP_Bartworth(1,f,0.01); %����n=1������ǿ��noise=0.01
  end
figure,plot(S);%����PSNRֵ�ֲ�
title('PSNR�ֲ�ͼ');xlabel('��ֹƵ��d0');ylabel('PSNRֵ')
M = max( S ) %������PSNRֵ���ҵ����ֵ
find(S==M)%�ó����PSNR��Ӧ�Ľ�ֹƵ��d0

