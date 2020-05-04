clear all;
close all;
clc;
res = [];
% probability = 0.2;
for probability=[0.05,0.1,0.2]
res1 = [];
for sz_x = [3,5,7,9]
% probability = 0.2; % Density
% sz_x = 5;
sz_y = sz_x;
% mu_x = 0;
% mu_y = mu_x;
% x = linspace(-2, 2, sz_x);
% y = linspace(-2, 2, sz_y);
% kernel = exp( -((x-mu_x).^2+ (y-mu_y)'.^2 )./2 ) ./ (2*pi);

imm = rgb2gray(imread('Lena.bmp'));
im = imm;

% adding salt & pepper
rn = rand(size(im));
im(rn < probability/2) = 0;
im((rn >= probability/2) & (rn < probability)) = 255;
im = uint8(im);

[s,ss] = size(im);
hx = floor(sz_x/2);
hy = floor(sz_y/2);
% Padding
im2 = [im(1:hy,:);
       im(:,:);
       im(s-hy+1:s,:);];
im2 = [im2(:,1:hx), im2, im2(:, ss-hx+1:ss)];
im3 = uint8(imm.*255);
% figure,imshow(im2);
for i=hx+1:s+hx
   
    for j=hy+1:ss+hy
        tmp = im2(i-hx:i+hx,j-hy:j+hy);
        tmp = median(tmp(:));
        im3(i-hx, j-hy) = tmp;
    end
    
end

% imwrite(im,['results\median-filter\lena-',num2str(sz_x),'x',num2str(sz_x),'-',num2str(probability),'-conditional.bmp']);
imwrite(im3,['321\',num2str(probability),'\',num2str(immse(imm,im3)),'-lena-',num2str(sz_x),'x',num2str(sz_x),'.bmp']);

end

end

