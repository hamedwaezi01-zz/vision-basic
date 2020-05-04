close all; clear all; clc;


im = rgb2gray(imread('Lena.bmp'));

kernela = [0,0,0;1,0,0;0,-1,0];
kernelb = [0,0,0;0,0,1;0,-1,0];

a=convolve(im,kernela);
b=convolve(im,kernelb);
% imwrite(a,'342/a.bmp');
% imwrite(b,'342/b.bmp');
% imwrite(a+b,'342/ab.bmp');
% figure,imshow(a);
% figure,imshow(b);








