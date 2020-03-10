clc;
clear all;
close all;


degree = 10;
tetha = pi /180.0 * degree;
co = cos(tetha);
si = sin(tetha);
im = imread('Elaine.bmp');

[r,c, channels] = size(im);
d = round(sqrt(r*r+c*c)) + 1;

imm = uint8(ones(d,d)*(-1));
mid_x = c/2;
mid_y = r/2;

shift_x = (d-c)/2;
shift_y = (d-r)/2;

tr = [co, -si, 0; si, co, 0;0,0,1] * [1,0,-mid_x; 0,1,-mid_y; 0,0,1];
%tr = [co, -si, -mid_x; si, co, - mid_y;0,0,1];
for i=1:r
    for j=1:c
        x = [i ;j;1 ];
        ij = round( [1,0,mid_x+shift_x; 0,1,mid_y+shift_y; 0,0,1] *tr*x);
%        ij = uint8([ij(1)+ r/2, ij(2)+ c/2]);
        imm(ij(1),ij(2)) = uint8(im(i,j));
    end
end
%imshow(im)
%figure,imshow(imm);

kernel = [0,1,0;1,0,1;0,1,0]  * 0.25;
%kernel = [0.25,0,0.25;0,0,0;0.25,0,0.25];
imm2 = imm;

for i=2:d-1
    
    for j=2:d-1
        if imm2(i,j) < 5
            s = double(imm2(i-1:i+1, j-1:j+1)) .* kernel;
            imm2(i,j) = uint8(sum(s(:)));
        end
    end
    
end

%figure,imshow(imm2)

imwrite([imm,imm2],['Elaine-rotated-',num2str(degree),'.jpg',]);
%imwrite(imm2,['Elaine-rotated-',num2str(degree),'-2.jpg',]);

