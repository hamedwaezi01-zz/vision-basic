clear all;close all; clc;

im = rgb2gray(imread('Lena.bmp'));

% imwrite(i,'Lena-box-3.bmp');
kernel = ones(3,3)/9;
% figure,imshow(im);
i = convolve(im,kernel);
i = convolve(i,kernel);
i = convolve(i,kernel);
% figure,imshow(i);
% imwrite(i,'Lena-box-3.bmp');
i = convolve(i,kernel);
i = convolve(i,kernel);
i = convolve(i,kernel);
% figure,imshow(i);
i = convolve(i,kernel);
i = convolve(i,kernel);
i = convolve(i,kernel);
% figure,imshow(i);
% imwrite(i,'Lena-box-9.bmp');
i = convolve(i,kernel);
i = convolve(i,kernel);
i = convolve(i,kernel);
% figure,imshow(i);

i = convolve(i,kernel);
i = convolve(i,kernel);
i = convolve(i,kernel);
% figure,imshow(i);
i = convolve(i,kernel);
i = convolve(i,kernel);
i = convolve(i,kernel);
% figure,imshow(i);
% imwrite(i,'Lena-box-18.bmp');
i = convolve(i,kernel);
i = convolve(i,kernel);
i = convolve(i,kernel);

ii = imgaussfilt(im,4);
immse(i,ii)
imshow([ii,i])

