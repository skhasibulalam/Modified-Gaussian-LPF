function [out] = conv2fft(a,b)
% FFT-based 2D convolution

ax=size(a,1);
ay=size(a,2);
bx=size(b,1);
by=size(b,2);

out=(ifft2(fft2(a,ax+bx-1,ay+by-1).*fft2(b,ax+bx-1,ay+by-1)));

px=((bx-1)+mod((bx-1),2))/2;
py=((by-1)+mod((by-1),2))/2;

% Now, we'll truncate the resultant matrix, matching the Image dimensions
out=out(px+1:px+ax,py+1:py+ay);
return;
end