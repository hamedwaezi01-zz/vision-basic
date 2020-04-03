% close all;
% clear all;
% clc;

%% histogram equalization 
function im2 = hist_equalization(im)
im = imread('Camera Man.bmp');
% im = rgb2gray(imread('Barbara.bmp'));
[s,ss] = size(im);
% Finding histogram
h = histo(im);
% Normalization of histogram
h = h ./ sum(h(:));
% Calculating normalization function
f = cumsum(h);
f = f ./ f(256) .* 255;
% making copy of image
im2 = im;
% Mapping image to new values in new
%  image corresponding to values of
%  original image
for i =1:s
    for j=1:ss
        im2(i,j) = f(im(i,j)+1);
    end
end

% imshow(im2);

end
%%


