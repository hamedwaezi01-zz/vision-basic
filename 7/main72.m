close all; clear all; clc;
%%%% Harris Corner Detector
%%
im = imread('Building.jpg');
% im = imresize(im,0.5);
im2 = im;
im = rgb2gray(im);

[s,ss] = size(im); % Satr, Soton
%%
sz_x = 3;
sz_y = sz_x;
mu_x = 0;
mu_y = mu_x;
half = 1;
sig = 1.0;
x = linspace(- half, half, sz_x);
y = linspace(- half, half, sz_y);
kernel = exp( -((x-mu_x).^2+ (y-mu_y)'.^2 )./(2*sig^2) ) ./ (2*pi*sig);
gauss = kernel ./ sum(kernel(:)); % Normalized
% % % gauss = [1 2 1; 2 4 2; 1 2 1] ./ 16;
sobelX = [1 0 -1; 2 0 -2; 1 0 -1];
sobelY = [1 2 1; 0 0 0; -1 -2 -1];

% smoothed = convolve(im,gauss);
dx = convolve(im, sobelX);
dx = dx./max(dx(:));
dy = convolve(im, sobelY);
dy = dy./max(dy(:));

dxdy = dx.*dy;
% figure,imshow([mat2gray(dy),mat2gray(dx)]);
% figure,imshow([mat2gray(dxdy)]);
dx2 = dx.^2;
dy2 = dy.^2;
dx2 = convolve(dx2,gauss);
dy2 = convolve(dy2,gauss);
dxdx = convolve(dxdy, gauss);
%%
detOfM = dx2.*dy2 - (dxdy .^2);
traceOfM = (dx2+dy2);
R = detOfM - 0.06 * traceOfM;
% normalized = harris./norm(harris);
% normalized = (harris - min(harris(:))) ./ (max(harris(:)) - min(harris(:)));
%%
thresh = 0;
% res = abs(harris) >= thresh;
% im2(:,:,1) = im2(:,:,1) + uint8(res.*255);
figure,imshow(im2);
[x,y,~] = find(R > thresh);

hold on;
plot(y,x, 'r.', 'MarkerSize', 5 )
hold off;



%%

