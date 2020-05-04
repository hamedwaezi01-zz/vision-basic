clear all;
close all;
clc;

im = rgb2gray(imread('Lena.bmp'));

for sigma=[0.01,0.05,0.1]
imm = imnoise(im,'gaussian',0,sigma);

for window=[3,5,7,9]
    
    [s,ss] = size(im);
    hx = floor(window/2);
    hy = hx;
    % padding
    im2 = [imm(1:hy,:);
       imm(:,:);
       imm(s-hy+1:s,:);];
    im2 = [im2(:,1:hx), im2, im2(:, ss-hx+1:ss)];
    im3 = im2;
    im4 = im2;
    % figure,imshow(im2);
    for i=hx+1:s+hx
        for j=hy+1:ss+hy
            tmp = im2(i-hx:i+hx,j-hy:j+hy);
            tmp = tmp(:);
            box = sum(tmp) / (window*window);
            medi = median(tmp);
            
            % Median
            im3(i, j) = medi;
            % Box Filter
            im4(i, j) = uint8(box);
        end
    end
    im3 = im3(hx+1:hx+s,hy+1:hy+ss);
    im4 = im4(hx+1:hx+s,hy+1:hx+ss);
    imwrite(im3,['322/',num2str(sigma),'/',num2str(immse(im,im3)),'-median-',num2str(window),'.bmp']);
    imwrite(im4,['322/',num2str(sigma),'/',num2str(immse(im,im4)),'-box-',num2str(window),'.bmp']);
    

end
end