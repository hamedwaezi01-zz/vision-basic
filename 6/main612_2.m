close all;
clear all; clc;

name = 'Lena.bmp'
levels = 4;

im = imread(name);
im = rgb2gray(im);

[s,ss] = size(im);
res = zeros(levels,s/2,ss/2);
ii = 1;
prev = double(im);

kernel = [0,0,0;0,1,1;0,1,1]./4;

for i=1:levels

new = double(convolve(prev,kernel));
tmp = new(1:2:end, 1:2:end);
[j,jj] = size(tmp);
res(i, 1:j,1:jj)= tmp;
prev = tmp;
end
i = i + 1;
[j,jj] = size(prev);
res(i, 1:j,1:jj)= prev;
for i=levels:-1:1
%     figure,imshow(uint8(squeeze(res(i,1:j,1:j))));
    imwrite(uint8(squeeze(res(i,1:j,1:j))), ['612\approx-',num2str(j),'.bmp'] );
    j = j * 2;
end

