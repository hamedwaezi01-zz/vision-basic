%%
close all;
clear all; clc;
%%% 2,0.05   0.8294     176.70  5
%%% 2,0.2    0.8754     120.50  4

whichIm = 2;

im = imread(['Attack 1\',num2str(whichIm),'.bmp']);
im = rgb2gray(im);

org = imread(['reference.bmp']);
org = rgb2gray(org);

pointsA = detectFASTFeatures(im,'MinContrast', 0.2);
pointsB = detectFASTFeatures(org);

% pointsA = detectSURFFeatres(im);
% pointsB = detectSURFFeatures(org);

% pointsA = detectMSERFeatures(im);
% pointsB = detectMSERFeatures(org);

% pointsA = detectBRISKFeatures(im);
% pointsB = detectBRISKFeatures(org);

% pointsA = detectKAZEFeatures(im);
% pointsB = detectKAZEFeatures(org);

% figure,imshow(im);hold on;
% plot(pointsA(1:end));
% hold off;
% 
% figure,imshow(org);hold on;
% plot(pointsB(1:end));
% hold off;

%%
[featuresA, pointsA] = extractFeatures(im, pointsA);
[featuresB, pointsB] = extractFeatures(org, pointsB);
%%
% indexPairs = matchFeatures(featuresA, featuresB, 'MaxRatio',0.9);
val = 9.0;
%%% 1: val=09.0
%%% 2: val=15.0
%%% 3: val=10.0
%%% 4: val=25.0
indexPairs = matchFeatures(featuresA, featuresB, 'MatchThreshold',val);
matchedPointsA = pointsA(indexPairs(:,1),:);
matchedPointsB = pointsB(indexPairs(:,2),:);

A = matchedPointsA.Location;
B = matchedPointsB.Location;

x = A(:,1);
y = A(:,2);

% A = [A,ones(size(A,1),1)];
% B = [B,ones(size(B,1),1)];
% M = (A'*A)\(A'*B);
% M = inv(A*A')*A*B';
% M = inv (B*B')*B*A';
M = fitgeotrans(A,B,'affine');
% M = B*A'*inv(A*A');
% res=imwarp(im,M,'OutputView',imref2d(size(org)));
image = rgb2gray(imread(['Attack 2\',num2str(whichIm),'.bmp']));
original = rgb2gray(imread('Original.bmp'));
res=imwarp(image,M,'OutputView',imref2d(size(original)));

% rr = floor(127/2);
% res = res(rr+1:rr+385,rr+1:rr+385);
%%% 3: ssim     0.6381
%%% 3: mse      532.49
% figure,imshow(res)
[ssim(res,original),immse(res,original),size(A,1)]
% [ssim(res,image),immse(res,image),size(A,1)]
figure,imshow(im)
hold on;
plot(x,y, 'r.', 'MarkerSize', 10)
hold off;
figure,imshow(res)
hold on;
x = B(:,1);
y = B(:,2);
plot(x,y, 'r.', 'MarkerSize', 10)
hold off;
%%
% padding = 400;
% M = [1,0,padding;0,1,padding;0,0,1] * M;
% % M = inv(M);
% % % M = M*[1,0,padding;0,1,padding;0,0,1];
% % % M = inv(M);
% % res = zeros(size(org).*2);
% % [s,ss] = size(im);
% % 
% % for i=1:s
% %     for j=1:ss
% %         if(im(i,j,:) ~= 0)
% %             ij = round(M*[i;j;1]);
% %             
% %             res(ij(1),ij(2)) = im(i,j,:);
% %         end
% %     end
% % end
% % figure,imshow([uint8(res)])





