% close all;
clear all; clc;
% name = 'Santoor.jpg';
name = 'Lena.bmp';
% name = 'noisy.bmp';
im = imread(name);
im = rgb2gray(im);
im = imresize(im,[512 512]);
% imwrite(im,'621/noisyy.bmp');
levels = 4

sigma = 0.1
imn = imnoise(im, 'gaussian',0, sigma);

filtertype='db2';
[s,ss] = size(im);
cA = im;
c = zeros(s);
ii = s;
for i=1:3
[cA,cH,cV,cD] = dwt2(cA,'haar');
% cA = mat2gray(cA);
% cH = mat2gray(cH);
% cV = mat2gray(cV);
% cD = mat2gray(cD);
tmp = [cA,cH; cV, cD];
c(1:ii, 1:ii) = tmp;
ii = ii / 2;
end
sz_x = 3;
sz_y = sz_x;
mu_x = 0;
mu_y = mu_x;
m = 0.5;
x = linspace(-m, m, sz_x);
y = linspace(-m, m, sz_y);
kernel = exp( -((x-mu_x).^2+ (y-mu_y)'.^2 )./2 ) ./ (2*pi);
% % % % c(256:end,1:end) = median_filter(c(256:end,1:end), 3);
% % % % c(1:256,256:end) = median_filter(c(1:256,256:end), 3);
% c(256:end,1:end) = convolve(c(256:end,1:end),kernel);
% c(1:256,256:end) = convolve(c(1:256,256:end),kernel);
% % c(256:end,256:end) = convolve(c(256:end,256:end),kernel);
% c = median_filter(c(256:end,1:255),3);

h = zeros(size(c));
T = 5;
% cnew = c(s(1,1)^2+1: end);
c(abs(c) <= T) = 0;
c(abs(c) > T) = sign(c(abs(c) > T)) .* (abs(c(abs(c) > T)) - T);
c(256:end,1:end) = convolve(c(256:end,1:end),kernel);
c(1:256,256:end) = convolve(c(1:256,256:end),kernel);

for i=1:3
ii = ii * 2;
pic = c(1:ii, 1:ii);
half = ii/2;
cA = pic(1:half, 1:half);
cH = pic(1:half, half+1:end);
cV = pic(half+1:end, 1:half);
cD = pic(half+1:end, half+1:end);
pic = idwt2(cA, cH, cV, cD, 'haar');
c(1:ii, 1:ii) = pic;
% imwrite(uint8(pic), ['613/idwt2-',num2str(ii),'.bmp'])
% figure,imshow(uint8(pic));
end
c=uint8(c);
figure,imshow([c,im]);
% imwrite(c,['621/0noisy-soft-',filtertype,'-',num2str(T),'.bmp']);
immse(c,im)
psnr(c,im)
ssim(c,im)



