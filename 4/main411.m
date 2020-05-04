close all; clear all; clc;

im = imread('Barbara.bmp');
im = rgb2gray(im);
% k0 = [1 2 1; 2 4 2; 1 2 1] ./ 16;

% k0 = [-1 -1 -1;
%     -1 8 -1;
%     -1 -1 -1];
% kernel
k0 = [0 -1 0;
    -1 5 -1;
    0 -1 0];
% k1 = [1 2 1]' /4;
% k2 = [1 2 1] /4;

[s,ss] = size(im);

res0 =  conv2(im,k0);
% setting dimensions of
%  fourier transform
n = 2^(ceil(log2(s))  + 1);
m = 2^(ceil(log2(ss)) + 1);

% Transforming image
res = dft2(im, m, n, -1);
% Trasforming Kernel
ff = dft2(k0,  m, n, -1);
figure,showdft2(ff);
writedft2(ff,'411/ffc.bmp');
% f1 = dft2(k1, m, n, -1);
% f2 = dft2(k2, m, n, -1);


% res2 = res .* f2 .* f1;
% res3 = res .* ff;
% writedft2(f1,'411/ff1.bmp');
% writedft2(f2,'411/ff2.bmp');


res1 = ff .* res;
% res2 = uint8(real(idft2(res2,s,ss, -1)));
res1 = uint8(real(idft2(res1,s,ss, -1)));
res = uint8(real(idft2(res,s,ss, -1)));

% bias1 = 1;
% res0 = res0(1+bias1:s-bias1,1+bias1:ss-bias1);

% res1 = res1(1+bias:s-bias,1+bias:ss-bias);
% im = im(1+bias:s-bias,1+bias:ss-bias);
% res = res(1+bias:s-bias,1+bias:ss-bias);
% figure,imshow([res0,res1]);
% immse(res1,res2)
immse(res0,res1)
immse(im, res)

figure,imshow([res0,res1]);







%%%%%%%%%%%%%
% % f = res.*ff;
% % 
% % f = uint8(real(idft2(f,s,ss, -1)));
% % figure,imshow(f);
imwrite(res1,'411/c.bmp');




