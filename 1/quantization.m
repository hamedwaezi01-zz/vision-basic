clc
clear all;
close all;


levels2 = [8,16,32,64,128];
%levels = [31,15,7,3,1];
levels = [32,16,8,4,2];
%levels = [16,32,64,128,256];
im = imread('Barbara.bmp');
im = rgb2gray(im);
eq = histeq(im);
err = zeros(5,2);
for i=1:size(levels,2)
    new = round(im ./ levels(i));
    new = round(new * levels(i));
    
    new_eq = round(eq ./ levels(i));
    new_eq = round(new_eq * levels(i));
    %new2 = histeq(new,256/levels(i));
    %new2 = round(new2 ./ levels(i)) * levels(i);
    
    err(i,1) = immse(im,new);
    err(i,2) = immse(eq,new_eq);
%     f = figure;
%     histogram(new);
%     hold on;
    %savefig(['leve(',num2str(256/levels(i)),')'])
    
    
%     saveas(f,['level(',num2str(256/levels(i)),').jpg']);
    
%     hold off;
    %imwrite([new,new_eq],['quantized-',num2str(err(i)),'.jpg']);
end
%figure, imshow(im);







