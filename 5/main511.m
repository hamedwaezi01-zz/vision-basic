close all; clear all; clc;


im = imread('Pepper.bmp');
[s,ss,channels] = size(im);

% H = zeros(s,ss);
im = double(im);
r = double(im(:,:,1));
g = double(im(:,:,2));
b = double(im(:,:,3));
S = 1 - ( 3 ./sum(im,3) .* min(im,[],3));

a1 = b > g;
H = acos(( 2*r - g - b ) ./ (2* sqrt( (r-g).^2 + (r-b).*(g-b) ) ) );
max(H(:))
H(a1) = 2*pi - H(a1);
I = (r+g+b)./3;

% H = H ./ max(H(:));

HH = mat2gray(H);
SS = mat2gray(S);
II = mat2gray(I);


% figure,imshow(S)
% figure,imshow(H)
% figure,imshow(HH)
% figure,imshow(SS)
% figure,imshow(II)
figure,imshow([HH,SS,II])