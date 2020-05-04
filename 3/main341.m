clear all; close all; clc;

im = rgb2gray(imread('Lena.bmp'));

% k1 = [1,0,-1]'/2;
k1 = [0,0,0;1,0,-1;0,0,0]/2;
k2 = [1,0,-1;1,0,-1;1,0,-1;]'/6;
k3 = [1,0,-1;2,0,-2;1,0,-1]./8;
% k4 = [0,-1,0;0,0,0;0,1,0]/2;

i1 = convolve(im,k1);
i2 = convolve(im,k2);
i3 = convolve(im,k3);
i33 = convolve(im,k3');
rs = i3+i33;
imwrite(rs,['341/2d.bmp']);
% i4 = convolve(im,k4);

% imwrite(i1,['341/a.bmp']);
% imwrite(i2,['341/bb.bmp']);
% imwrite(i3,['341/cc.bmp']);
% imwrite(i4,['341/d.bmp']);
% figure,imshow([im,i1;i2,i3]);
% figure,imshow([i1+i4]);
% imwrite([i3,ones(512,25).*255,i2], 'lena-derivate.bmp');

