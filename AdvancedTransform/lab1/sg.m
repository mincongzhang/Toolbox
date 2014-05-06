function  sg( s,N )
%SPECGRAM Spectrogram using a Short-Time Fourier Transform (STFT).
%   This function computes a spectrogram of a waveform s with window size N (NFFT in Matlab¡¯s specgram).
%   If s cannot be divided exactly into certain segments, s will be truncated accordingly.
%   Author: Mincong Zhang

size_s=size(s);
length_s=size_s(1);
segment_s=fix(length_s/N);%truncated

%new sequence created
f_s=zeros(1,segment_s*N);
W=hanning(N);

%for each segment, perform an FFT
for k=1:segment_s
    s1=s( ((1:N)+(k-1)*N) ).*W;
    y=abs(fft(s1)); 
    f_s=y(1:fix(N/2)+1); %discard one half
                         %if nfft is even,(nfft/2+1) rows , and if nfft is odd, (nfft+1)/2 rows .
                         %i.e.1:fix(N/2)+1
    M(:,k)=f_s';
end

size_M=size(M);
length_M=size(2);

%Overlap 50%
for i=1:length_M
    %substract the 50% in the next vector and add them to the current vector
    for k=ceil(segment_s/2):segment_s   
        M(i,k)=M(i,k)+M(i+1,k);
    end
end

imagesc(log10(abs(M))); axis xy;
    xlabel('Time');
    ylabel('Frequency');
    title('SG (created by Mincong Zhang)');
end

