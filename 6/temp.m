% close all;
clear all; clc;

name = 'Lena.bmp'
levels = 3;

im = imread(name);
im = rgb2gray(im);

% % % 
% % % res = get_prediction(im,3);
% % % % res = get_approximation(im,3);
% % % for i=1:3
% % %     tmp = res(i,:,:);
% % % 	figure,imshow(mat2gray(squeeze(tmp)));
% % % end

% % % % % % % % % % % sigma = 0.01
% % % % % % % % % % % im = imnoise(im, 'gaussian',0, sigma);
% % % % % % % % % % % [s,ss] = size(im);
% % % % % % % % % % % cA = im;
% % % % % % % % % % % res = zeros(s);
% % % % % % % % % % % ii = s;
% % % % % % % % % % % % for i=1:3
% % % % % % % % % % % % [cA,cH,cV,cD] = dwt2(cA,'haar');
% % % % % % % % % % % % % cA = mat2gray(cA);
% % % % % % % % % % % % % cH = mat2gray(cH);
% % % % % % % % % % % % % cV = mat2gray(cV);
% % % % % % % % % % % % % cD = mat2gray(cD);
% % % % % % % % % % % % tmp = [cA,cH; cV, cD];
% % % % % % % % % % % % res(1:ii, 1:ii) = tmp;
% % % % % % % % % % % % ii = ii / 2;
% % % % % % % % % % % % end
% % % % % % % % % % % 
% % % % % % % % % % % M = size(im,1)^2;
% % % % % % % % % % % T = 22.6274*2
% % % % % % % % % % % % T = 18
% % % % % % % % % % % % T = 2500*sigma;
% % % % % % % % % % % % figure,imshow(mat2gray(res));
% % % % % % % % % % % ind = find(abs(res) <= T);
% % % % % % % % % % % res(ind) = 0;
% % % % % % % % % % % % ind = find(abs(res) > T);
% % % % % % % % % % % % res(ind) = sign(res(ind)) .* (abs(res(ind)) - T);
% % % % % % % % % % % 
% % % % % % % % % % % % figure,imshow(mat2gray(res));
% % % % % % % % % % % imwrite(res, '621/h-threshold-4-level-quantized-wavelet.bmp')
% % % % % % % % % % % 
% % % % % % % % % % % for i=1:3
% % % % % % % % % % % ii = ii * 2;
% % % % % % % % % % % pic = res(1:ii, 1:ii);
% % % % % % % % % % % half = ii/2;
% % % % % % % % % % % cA = pic(1:half, 1:half);
% % % % % % % % % % % cH = pic(1:half, half+1:end);
% % % % % % % % % % % cV = pic(half+1:end, 1:half);
% % % % % % % % % % % cD = pic(half+1:end, half+1:end);
% % % % % % % % % % % pic = idwt2(cA, cH, cV, cD, 'haar');
% % % % % % % % % % % res(1:ii, 1:ii) = pic;
% % % % % % % % % % % imwrite(uint8(pic), ['621/h-threshold-quantized-idwt2-',num2str(ii),'.bmp'])
% % % % % % % % % % % end
% % % % % % % % % % % 
% % % % % % % % % % % figure,imshow([mat2gray(im), mat2gray(pic)]);
% % % % % % % % % % % imwrite([mat2gray(im), mat2gray(pic)], ['621/noisy-and-h-threshold-','.bmp'])

sigma = 0.01
im = imnoise(im, 'gaussian',0, sigma);

filtertype='db2'
[c,s] = wavedec2(im,levels, filtertype);


h = zeros(size(size(c)));
T = 35;
cnew = c(s(1,1)^2+1: end);
cnew(abs(cnew) <= T) = 0;
cnew(abs(cnew) > T) = sign(cnew(abs(cnew) > T)) .* (abs(cnew(abs(cnew) > T)) - T);

cs = [c(1:s(1,1)^2), cnew];

res = uint8(waverec2(cs,s,filtertype));
figure,imshow(res);
% imwrite(res,['621/lena-soft-denoised-',filtertype,'-',num2str(T),'.bmp']);






