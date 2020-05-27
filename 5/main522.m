close all; clear all; clc;

im = imread('Pepper.bmp');
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

rr = quantize(r,8);
gg = quantize(g,8);
bb = quantize(b,4);

res = uint8(zeros(size(im)));
res(:,:,1) = rr;
res(:,:,2) = gg;
res(:,:,3) = bb;
% figure,imshow([im,res]);
imwrite(res, ['522/res.bmp'])