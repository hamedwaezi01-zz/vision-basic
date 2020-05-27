close all; clear all; clc;

im = imread('Pepper.bmp');
L = [64,32,16,8,4,2];
res = uint8(zeros(size(im)));
res_mse = zeros(4,1,3);
res_psnr = zeros(4,1,3);
res_ssim = zeros(4,1,3);
for i=1:size(L,2)
res = quantize(im, L(i));
% res_mse(i,:,:) = mse(im,res);
% res_psnr(i,:,:) = psnr(im,res);

imwrite(res,['521/',num2str(L(i)),'.bmp']);
end

% figure, imshow(res);