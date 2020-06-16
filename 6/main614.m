close all;
clear all; clc;


name = 'Lena.bmp'
sigma = 0.01;
im = imread(name);
im = rgb2gray(im);
% im = imnoise(im, 'gaussian',0, sigma);
[s,ss] = size(im);
cA = im;
res = zeros(s);
ii = s;
for i=1:3
[cA,cH,cV,cD] = dwt2(cA,'haar');
% cA = mat2gray(cA);
% cH = mat2gray(cH);
% cV = mat2gray(cV);
% cD = mat2gray(cD);
tmp = [cA,cH; cV, cD];
res(1:ii, 1:ii) = tmp;
ii = ii / 2;
end

gamma = 4;
res = gamma .* sign(res) .* floor(abs(res)/gamma);
% imwrite(res, '614/4-level-wavelet.bmp')

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
% imwrite(uint8(pic), ['614/quantized-idwt2-',num2str(ii),'.bmp'])
end


res = uint8(pic);
figure,imshow([im, pic]);
immse(res,im)
psnr(res,im)
ssim(res,im)
% imwrite([uint8(pic)], ['614/quantized','.bmp'])