close all;
clear all; clc;

name = 'Lena.bmp'
levels = 4;

im = imread(name);
im = rgb2gray(im);
[s,ss] = size(im);
tmp = zeros(levels,s,ss);
ii = 1;
prev = double(im);
% % % Downsampling
for i=1:levels-1
kernel = [0,0,0;0,1,1;0,1,1]./4;
new = double(convolve(prev,kernel));
res2 = new(1:2:end, 1:2:end);

res = prev - resizem(res2,2);
[j,jj] = size(res);
tmp(i, 1:j,1:jj)= res;
res = res(1:2:j, 1:2:jj);
prev = res2;
% figure,imshow(mat2gray(res));
end
clear res2;
i = i + 1;
[j,jj] = size(prev)
tmp(i, 1:j,1:jj)= prev;

% % % Upsampling
f1 = squeeze(tmp(levels,1:j,1:j));
for i=levels-1:-1:1
j = floor(s./2.^(i-1));
f2 = squeeze(tmp(i,1:j,1:j));
new = resizem(f1,2);


f1 = new + f2;
% imwrite(uint8(f1),['tmp/',num2str(j),'.bmp']);
% figure,imshow([mat2gray(f1),mat2gray(f2)]);
end


% [cA,cH,cV,cD] = mydwt2(im);
% cA = mat2gray(cA);
% cH = mat2gray(cH);
% cV = mat2gray(cV);
% cD = mat2gray(cD);
% tmp = [cA,cH; cV, cD];
% figure,imshow(tmp);
res = uint8(f1);
[immse(res,im) psnr(res,im) ssim(res,im)]


