a=imread('actual.jpg');% Use your desired Image file in this line.
level=2;% Number of times each "FOR-LOOP" you want to run.
% By the way, there are 2 FOR-LOOPs in this code.

in=double(a);
x=-15:15;
y=-15:15;
sigma=2;
g=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
        g(i,j)=exp(-(x(i)^2+y(j)^2)/(2*sigma^2));
    end
end
g=g/(2*pi*sigma^2);

d_image=double(a);% Convert to "double precision" from "Integer(depth-8)" 
dmin=min(size(d_image,[1 2]));% Minimum between height & width of that Image

% You simply don't want to downsample a "4x4 matrix" more than 2 times.
dsamp_level=floor(log2(dmin));
% This will automtically override if you're wrong in "line 6" before.
fin_level=min(dsamp_level,level);

for i=1:fin_level
    filtered_r = myfun(d_image(:,:,1),g);
    filtered_g = myfun(d_image(:,:,2),g);
    filtered_b = myfun(d_image(:,:,3),g);
    dsamped_r = dyaddown(filtered_r,1,'m');
    dsamped_g = dyaddown(filtered_g,1,'m');
    dsamped_b = dyaddown(filtered_b,1,'m');
    clear recur_down;
    recur_down(:,:,1) = dsamped_r;
    recur_down(:,:,2) = dsamped_g;
    recur_down(:,:,3) = dsamped_b;
    d_image = recur_down;
end
% 1st "FOR-LOOP" is done, now we're entering the 2nd "FOR-LOOP".
for i=1:fin_level
    usamped_r = dyadup(d_image(:,:,1),1,'m');
    usamped_g = dyadup(d_image(:,:,2),1,'m');
    usamped_b = dyadup(d_image(:,:,3),1,'m');
    usamped_r = usamped_r(2:size(usamped_r,1),2:size(usamped_r,2));
    usamped_g = usamped_g(2:size(usamped_g,1),2:size(usamped_g,2));
    usamped_b = usamped_b(2:size(usamped_b,1),2:size(usamped_b,2));
    filtered_r = 4*myfun(usamped_r,g);
    filtered_g = 4*myfun(usamped_g,g);
    filtered_b = 4*myfun(usamped_b,g);
    clear d_image;
    d_image(:,:,1) = filtered_r;
    d_image(:,:,2) = filtered_g;
    d_image(:,:,3) = filtered_b;
end

out = uint8(d_image);
imwrite(out,'compressed.jpg');

pin=sum(sum(sum(in.^2)));
pnoi=sum(sum(sum((in-d_image).^2)));
snr=pin/pnoi

function [out] = myfun(a,b)
[ax,ay]=size(a,[1 2]);
[bx,by]=size(b,[1 2]);
out=(ifft2(fft2(a,ax+bx-1,ay+by-1).*fft2(b,ax+bx-1,ay+by-1)));
px=((bx-1)+mod((bx-1),2))/2;
py=((by-1)+mod((by-1),2))/2;
out=out(px+1:px+ax,py+1:py+ay);
return;
end
