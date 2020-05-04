close all; 
clear all; clc;

name = 'Barbara';
im = imread([name,'.bmp']);
im = rgb2gray(im);
im = double(im);

[s,ss] = size(im);
n = 2^(ceil(log2(s))  );
m = 2^(ceil(log2(ss)) );

fourier1 = dft2(im,m,n, -1);
fourier2 = dft2(im,m,n, +1);
% figure,showdft2(fourier1);
% figure,showdft2(fourier2);
x1 = mat2gray(log(abs(fourier1) +1));
x2 = mat2gray(log(abs(fourier2) +1));
x3 = mat2gray(abs(fourier1));
x4 = mat2gray(abs(fourier2));
% imwrite(x1, ['412/',name,'-log-shift.bmp']);
% imwrite(x2, ['412/',name,'-log.bmp']);
% imwrite(x3, ['412/',name,'-shift.bmp']);
% imwrite(x4, ['412/',name,'.bmp']);

% imwrite([x1,x4], ['412/side/',name,'x14.bmp']);
% imwrite([x2,x3], ['412/side/',name,'x23.bmp']);














