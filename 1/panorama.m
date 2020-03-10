clear all;
close all;
clc;


padding = 100;
i1 = imread('Car1.jpg');
i2 = imread('Car2.jpg');
[height,width, channels] = size(i1);
im = [i1, i2];
figure,imshow(im)

% % % Code for selecting points
% 
% 
% points1 = [[],[],[]];
% points2 = [[],[],[]];
% hold on;
% for i=[1,2,3]
%     
%     [points1(i,1),points1(i,2)] = ginput(1);
%     scatter(points1(i,1),points1(i,2),10,'y','filled');
%     
%     [points2(i,1),points2(i,2)] = ginput(1);
%     scatter(points2(i,1),points2(i,2),10,'r','filled');
% end
% points1 = [points1'; 1 1 1]
% points2 = [points2'; 1 1 1]
% 
% hold off;

% points1 = round([5.797500000000000e+02,6.967500000000000e+02,7.537500000000000e+02;4.917499999999999e+02,4.887499999999999e+02,3.147499999999999e+02;1,1,1]);
% points2 = round([1.155750000000000e+03,1.278750000000000e+03,1.338750000000000e+03;5.157500000000000e+02,5.067500000000001e+02,3.357499999999999e+02;1,1,1]);


points1 = [4.755859106529209e+02,5.718058419243986e+02,8.312560137457045e+02;4.760154639175257e+02,3.351219931271477e+02,3.454312714776631e+02;1,1,1];
points2 = [1.044314432989691e+03,1.150843642611684e+03,1.413730240549829e+03;4.983522336769759e+02,3.488676975945016e+02,3.660498281786941e+02;1,1,1];
% % % % % % % hold on;
% % % % % % % tmp = points1';
% % % % % % % tmp2 = points2';
% % % % % % % for i=1:3
% % % % % % %    
% % % % % % %     scatter(tmp(i,1),tmp(i,2),10,'r','filled');
% % % % % % %     scatter(tmp2(i,1),tmp2(i,2),10,[0.5,0,0.5],'filled');
% % % % % % %     
% % % % % % %     
% % % % % % % end
% % % % % % % 
% % % % % % % hold off;
im2 = uint8(zeros(2*padding+height, 2*(padding+width),3));
% points1 = [5.887500000000000e+02,6.967500000000000e+02,7.852500000000000e+02;4.602499999999999e+02,4.797499999999999e+02,3.867499999999999e+02;1,1,1];
% points2 = [1.167750000000000e+03,1.278750000000000e+03,1.367250000000000e+03;4.812499999999999e+02,4.992500000000000e+02,4.062499999999999e+02;1,1,1];
mm = [
    1,0,padding;
    0,1,padding;
    0,0,1;
];

%m = [582,483,1;757,461,1;790,336,1] / [160+width,504,1;339+width,479,1;373+width,356,1]


m = points1 / points2
% m = [
%     1,0,-578;
%     0,1,-27;
%     0,0,1;
% ];


%im2(50:799, 50:1049,:) = i1(:,:,:);

for i=1:height
    
    for j=1:width
       
        x = [i,j,1]';
        ij = mm*x;
        im2(ij(1),ij(2),:) = im(i,j,:);
        
    end
    
end



m = mm * m 
for i=1:height
    
    for j=width+1:width*2
        x = [j,i,1]';
        ij = round(m*x);
%        ij = uint8([ij(1)+ height/2, ij(2)+ width/2]);
        im2(ij(2),ij(1),:) = uint8(im(i,j,:));
    end
    
end
kernel = [0,1,0;
          1,0,1;
          0,1,0;] * 0.25;
%kernel = [0.25,0,0.25;0,0,0;0.25,0,0.25];

for i=2:height+100
    
    for j=2:width*2+100
        if im2(i,j) < 5
            s1 = double(im2(i-1:i+1, j-1:j+1,1)) .* kernel;
            s2 = double(im2(i-1:i+1, j-1:j+1,2)) .* kernel;
            s3 = double(im2(i-1:i+1, j-1:j+1,3)) .* kernel;
            
            im2(i,j,:) = uint8([sum(s1(:));sum(s2(:));sum(s3(:))]);
        end
    end
    
end



figure,imshow(im2)



% 
% 483, 582		504,160
% 461,757			479,339
% 336,790			356,373
% 
