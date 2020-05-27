close all; clear all; clc;

im = imread('girl.bmp');
[s,ss,ch] = size(im);
k = 16;

X = zeros(s*ss,3);

tmpp = im(:,:,1);
X(:,1) = tmpp(:);
tmpp = im(:,:,2);
X(:,2) = tmpp(:);
tmpp = im(:,:,3);
X(:,3) = tmpp(:);

[idx,c] = kmeans(X,k);
res = c(idx,:);
res = uint8(round(reshape(res,[s,ss,3])));
% figure,imshow(res)
% imwrite(res,['523/gal-',num2str(k),'.bmp']);
% [psnr(im,res), immse(im,res), ssim(im,res)]


