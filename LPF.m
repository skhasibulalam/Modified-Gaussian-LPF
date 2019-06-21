clc
clear all

a = imread('bsec.jpg');% Use your desired Image file in this line.

level=1;% Number of times each "FOR-LOOP" you want to run.
% By the way, there are 2 FOR-LOOPs in this code.

% Now we'll declare our Gaussian Filter length.
x=[-10:1:10];
y=[-10:1:10];
fil_r=size(x,2);
fil_c=size(y,2);
variance=3;% It is actually: 2 x (sigma)^2.
gaussi=zeros(fil_r,fil_c);
for i=1:fil_r
    for j=1:fil_c
        expon=exp(-(x(i)^2+y(j)^2)/(variance));
        gaussi(i,j)=expon;
    end
end
% Filter is ready. Now we need to normalize, otherwise the output Image
% will be too white or too black.
gaussi=gaussi/sum(sum(gaussi));

d_image= double(a);% Convert to "double precision" from "Integer(depth-8)" 
d_r= size(d_image,1);
d_c= size(d_image,2);
dmin= min(d_r,d_c);% Minimum between height & width of that Image

% You simply don't want to downsample a "4x4 matrix" more than 2 times.
dsamp_level= floor(log2(dmin));
% This will automtically override if you're wrong in "line 6" before.
fin_level= min(dsamp_level,level);

image_cell=cell(fin_level+1,1);
image_cell{1}=d_image;

for i=1:fin_level
    filtered_r = conv2fft(d_image(:,:,1),gaussi);% Red Layer
    filtered_g = conv2fft(d_image(:,:,2),gaussi);% Green Layer
    filtered_b = conv2fft(d_image(:,:,3),gaussi);% Blue Layer
    dsamped_r = dyaddown(filtered_r,1,'m');% Downsampling R
    dsamped_g = dyaddown(filtered_g,1,'m');% Downsampling G
    dsamped_b = dyaddown(filtered_b,1,'m');% Downsampling B
    clear recur_down;
    % Now we'll recombine R, G, B layer.
    recur_down(:,:,1) = dsamped_r;
    recur_down(:,:,2) = dsamped_g;
    recur_down(:,:,3) = dsamped_b;
    image_cell{i+1} = recur_down;
    d_image = recur_down;
end
% 1st "FOR-LOOP" is done, now we're entering the 2nd "FOR-LOOP".
for i=1:fin_level
    usamped_r = dyadup(d_image(:,:,1),0,'m');% Upsampling R
    usamped_g = dyadup(d_image(:,:,2),0,'m');% Upsampling G
    usamped_b = dyadup(d_image(:,:,3),0,'m');% Upsampling B
    % Multiplying with a factor "4", otherwise the Image would be faded.
    % You may use "3.8" or "4.2" instead; it's upto you.
    filtered_r = 4*conv2fft(usamped_r,gaussi);
    filtered_g = 4*conv2fft(usamped_g,gaussi);
    filtered_b = 4*conv2fft(usamped_b,gaussi);
    clear d_image;
    % Now we'll recombine R, G, B layer.
    d_image(:,:,1) = filtered_r;
    d_image(:,:,2) = filtered_g;
    d_image(:,:,3) = filtered_b;
end

out = uint8(d_image);
% Now, we'll save the filtered Image.
imwrite(out, 'comp.jpg');