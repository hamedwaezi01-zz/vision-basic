clear all;
% close all;
clc;
name = 'HE4'
im = rgb2gray(imread([name,'.jpg']));

for k=[64,128,256,512]
[s,ss] = size(im);
sz_x = k;
sz_y = sz_x;
step_x = sz_x;
step_y = sz_y;

padding_x = (sz_x - (ss - floor(ss/step_x) * step_x));
padding_y = ( sz_y - (s - floor(s/step_y) * step_y) );

im2 = [im,im(:,ss - padding_x:ss)];
im2 = [im2;im2(s - padding_y:s,:)];


kernel = ones(sz_x,sz_y);
res = zeros(s,ss);
for i =1:step_x:s
    for j=1:step_y:ss
        tmp = im2(i:i+sz_x-1, j:j+sz_y-1);
        h = localHistogram(kernel, tmp);
        h = h ./ sum(h);
        f = cumsum(h) .* 255;
        res(i:i+sz_x-1, j:j+sz_y-1) = localHisteq(tmp,f);
    end
end
res = uint8(res(1:s,1:ss));
imwrite(res, ['results\', name,'-',num2str(k),'.bmp']);
end
