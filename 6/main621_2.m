% close all;
clear all; clc;


% name = 'Santoor.jpg';
name = 'Lena.bmp';
% name = 'noisy.bmp';
im = imread(name);
im = uint8(rgb2gray(im));
levels = 5

sigma = 0.01
imn = imnoise(im, 'gaussian',0, sigma);

filtertype='db4';
[c,s] = wavedec2(imn,levels, filtertype);


% h = zeros(size(size(c)));
T = 30;
cnew = c(s(1,1)^2+1: end);
cnew(abs(cnew) <= T) = 0;
index = find(abs(cnew) > T);
cnew(index) = sign(cnew(index)) .* (abs(cnew(index)) - T);

cs = [c(1:s(1,1)^2), cnew];

res = waverec2(cs,s,filtertype);
% immse(res,im)
% psnr(res,im)
res = uint8(res);
figure,imshow(res);
% imwrite(res,['621/11lena-soft-',filtertype,'-',num2str(T),'.bmp']);

immse(res,im)
psnr(res,im)
ssim(res,im)
