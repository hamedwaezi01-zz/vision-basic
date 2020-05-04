close all; clear all; clc;


im = imread('Lena.bmp');
im = rgb2gray(im);
for window=[3,5,7,9]
smooth = imgaussfilt(im, 1.5, 'FilterSize', window );    
for a=[0.1,0.5,0.9]

mask = im + a.*(im-smooth);
% h = highboost(im,2,0.1);
% figure,imshow([im,mask,h]);
% [immse(im,mask),immse(im,h)]

u = (mask - im) .* 20;
% u2 = (h - im) .* 20;
% figure,imshow([u,u2; mask,h]);
imwrite([mask, ones(size(mask,1),25)*255,u],['351/unsharp-lena-',num2str(a),'-',num2str(window),'.bmp']);

% i = imsharpen(im, 'Radius', 3);
% imwrite([h, ones(size(mask,1),25)*255,u2],['351/highboost-lena.bmp']);
end
end