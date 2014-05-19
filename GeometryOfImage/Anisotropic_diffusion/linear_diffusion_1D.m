function run()
clc
clear
close all
set(0,'defaultfigurecolor','w');
I = imread('pout.tif');

f = double(I(:,100));
N = length(f);
A = zeros(N,N);

% figure,plot(f);

[row col] = size(A);
for k = 1:row
    for j = 1:col
        if(k == j)
            if(k == 1)          % first  elements
                A(k,j)   = -1;
                A(k+1,j) =  1;
            elseif (k == row)   % last   elements
                A(k,j)   = -1;
                A(k-1,j) =  1;
            else                % middle elements
                A(k,j)   = -2;
                A(k-1,j) =  1;
                A(k+1,j) =  1;
            end
        end
    end
end
% result = A*f;
% figure,plot(result);

%%
%Interation
yceil = max(f(:));
yfloor = min(f(:));
f_explicit = f;
f_implicit = f;
f_gaussian = f;

deltaT = 0.5;
iteration = 10;
std = sqrt(2*deltaT);
gaussian = gaussmf(-1:1:1,[std 0]);

set (gcf,'Position',[232 246 960 420], 'color','w');
for k = 1:iteration
    %explicit
    f_explicit = explicit(f_explicit,A,deltaT);
    subplot(1,3,1);plot(f_explicit); title({['Explicit Scheme '],['Iteration:',num2str(k),' deltaT:',num2str(deltaT)]});
    set(gca, 'XLim', [0 N]);
    set(gca, 'YLim', [yfloor yceil]);
    drawnow;
    
    %implicit
    f_implicit = implicit(f_implicit,A,deltaT,N);
    subplot(1,3,2);plot(f_implicit); title({['Implicit Scheme '],['Iteration:',num2str(k),' deltaT:',num2str(deltaT)]});
    set(gca, 'XLim', [0 N]);
    set(gca, 'YLim', [yfloor yceil]);
    drawnow;
    
    %convolve with gaussian filter
    f_gaussian = conv(f_gaussian,gaussian,'same');
    subplot(1,3,3);plot(f_implicit); title({['Gaussian Filter'],['Iteration:',num2str(k)]});
    set(gca, 'XLim', [0 N]);
    set(gca, 'YLim', [yfloor yceil]);
    drawnow;

%     pause(2);
end

end

%%
%Explicit
function fk = explicit(f,A,delta)
    fk = f + delta*A*f;
end

%Implicit
function fk = implicit(f,A,delta,N)
    fk = inv(eye(N)-delta*A)*f;
end