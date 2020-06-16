close all;
clear all; clc;

im = imread('Lena.bmp');
im = rgb2gray(im);
levels = 4;

ims2 = get_approximation(im,levels);
s = 512;
for i=1:levels
s = s/2;
% figure,imshow(uint8(squeeze(ims2(i,1:s,1:s))));
imwrite(uint8(squeeze(ims2(i,1:s,1:s))),['611/approx-gaussian-',num2str(i),'.bmp']);
end


ims = get_prediction(im,levels);
s = 512;
for i=1:levels

% figure,imshow(mat2gray(squeeze(ims(i,1:s,1:s))));
imwrite(mat2gray(squeeze(ims(i,1:s,1:s))),['611/pred-gaussian-',num2str(i),'.bmp']);
s = s/2;
end
res = reconstruct_prediction(ims,levels);
res =uint8(res);
figure,imshow(res)

immse(res,im)
psnr(res,im)
ssim(res,im)




