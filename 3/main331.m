clear all;close all;clc;

im = rgb2gray(imread('santoor.jpg'));
im = imnoise(im, 'gaussian', 0,0.001);
im = imresize(im,0.25);

i = gaussian_filter(im,0.2);
i = adapthisteq(im);

% kernel = [1,0,-1;
%           1,0,-1;
%           1,0,-1;];
% res = convolve(im, kernel);
res = highboost(i,2,0.15);
% figure,imshow(im);
imwrite(im,'331\im.bmp');
imwrite(i,'331\histeq.bmp');
imwrite(res,'331\final.bmp');

% res = unsharp(im,4,1);
