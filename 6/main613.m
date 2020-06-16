close all;
clear all; clc;

name = 'Lena.bmp'
im = imread(name);
% im = rgb2gray(im);
[s,ss] = size(im);
cA = im;
res = zeros(s);
ii = s;
for i=1:3
[cA,cH,cV,cD] = dwt2(cA,'haar');
% cA = mat2gray(cA);
cH = mat2gray(cH);
cV = mat2gray(cV);
cD = mat2gray(cD);
tmp = [cA,cH; cV, cD];
res(1:ii, 1:ii) = tmp;
ii = ii / 2;
end

res(1:ii, 1:ii) = mat2gray(cA);
figure,imshow(res);
% imwrite(res, '613/4-level-wavelet.bmp')

for i=1:3
ii = ii * 2;
pic = res(1:ii, 1:ii);
half = ii/2;
cA = pic(1:half, 1:half);
cH = pic(1:half, half+1:end);
cV = pic(half+1:end, 1:half);
cD = pic(half+1:end, half+1:end);
pic = idwt2(cA, cH, cV, cD, 'haar');
res(1:ii, 1:ii) = pic;
% imwrite(uint8(pic), ['613/idwt2-',num2str(ii),'.bmp'])
% figure,imshow(uint8(pic));
end






