function gaussian_filter = DtG(pattern,kernel_length,sigma)
    %%
    %0th order: G0
    X = [1:kernel_length]-kernel_length/2;
    gauss_x = 1/(sqrt(2*pi)*sigma)*exp(-0.5*X.^2/(sigma^2));
    gauss_y = gauss_x';

    G0 = gauss_y*gauss_x;
    G0 = G0./(max(G0(:)));

    if(pattern==0)
        gaussian_filter = G0;
    end

    %%
    %1st order: G1
    grad_x = [1 -1];
    G1_x = conv2(G0,grad_x,'same');

    grad_y = [-1 1]';
    G1_y = conv2(G0,grad_y,'same');

    if(pattern==1)
%         figure,subplot(1,2,1),imshow(G1_x); title('1st Order Kernel 1');
%         subplot(1,2,2),imshow(G1_y); title('1st Order Kernel 2');
        gaussian_filter(:,:,1) = G1_x;
        gaussian_filter(:,:,2) = G1_y;
    end

    %%
    %2nd order: G2
    grad_w1 = [0 -1;
               1 0];
    G2_w1 = conv2(G1_y,grad_w1,'valid');
    
    grad_w2 = [1 -1];
    G2_w2 = conv2(G1_x,grad_w2,'valid');
    G2_w2(end,:) = [];

    grad_w3 = [1 0;
               0 -1];
    G2_w3 = conv2(G1_x,grad_w3,'valid');
    if(pattern==2)
%         figure,subplot(1,3,1);imshow(G2_w1);title('2nd Order Kernel 1');
%         subplot(1,3,2),imshow(G2_w2);title('2nd Order Kernel 2');
%         subplot(1,3,3),imshow(G2_w3);title('2nd Order Kernel 3');
        gaussian_filter(:,:,1) = G2_w1;
        gaussian_filter(:,:,2) = G2_w2;
        gaussian_filter(:,:,3) = G2_w3;
    end
end