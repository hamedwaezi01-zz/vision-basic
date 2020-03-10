clc;
clear all;
close all;


im = imread('Goldhill.bmp');
[r,c, channels] = size(im);
original = im;


%%% Code for Averaging

% % begin

kernel = [
    0.5,0.5,0.5,0.5,0.5;
    0.5,1,1,1,0.5;
    0.5,1,1,1,0.5;
    0.5,1,1,1,0.5;
    0.5,0.5,0.5,0.5,0.5;
] ./ (3 ^ 2 + 8);


kernel = [
    0.25,0.5,0.25;
    0.5,1,0.5;
    0.25,0.5,0.25;
] ./ (4);

kernel_size = size(kernel, 1);
half = floor(kernel_size/2);

im = [im, zeros(size(im,2),half);
        zeros(half,size(im,1)+half)];
downsampled = uint8(zeros(size(original)/2));

for i=half+1:2:r- half + 1
    ii = floor(i/2);
    for j=half+1:2:c-half + 1
        
        tmp = double(im(i-half:i+half, j-half:j+half)) .* kernel;
        downsampled(ii, floor(j/2)) = uint8(sum(tmp(:)));
       
   end
    
end

figure,imshow(downsampled)
imwrite(downsampled,'goldhill-averaged.jpg');
%%% End of averaging code


% % % Code for removing row & column
% downsampled = im(1:2:r, 1:2:c); 
% imwrite(downsampled, 'goldhill-removed.jpg');




%%% Code for Pixel Replication
replicated = uint8(zeros(r,c));
replicated(1:2:r, 1:2:c) = downsampled(:,:);
replicated(2:2:r, 1:2:c) = downsampled(:,:);
replicated(:,2:2:c) = replicated(:,1:2:c);




%%% Bilinear Interpolation Code


up_kernel = [
    1,0,1;
    0,0,0;
    1,0,1;
] .* 0.25;

half = floor(size(up_kernel,1)/2);
upsampled = uint8(zeros(r,c));
upsampled(1:2:r-half, 1:2:c-half) = downsampled(:,:);
%%% border replication
upsampled(2:2:r, 1) = upsampled(1:2:r, 1); % left border
upsampled(1, 2:2: c ) = upsampled(1,1:2: c ); % top border
upsampled(2:2:r, (c - mod(c+1,2) ) ) = upsampled(1:2:r, (c - mod(c+1,2) ) ); % right border
upsampled( (r - mod(r+1, 2)) , 2:2:c ) = upsampled( (r - mod(r+1, 2)) , 1:2:c ); % % bottom border

upsampled( r, : ) = upsampled( r - mod(r+1,2),: );
upsampled( : , c ) = upsampled( :, c - mod(c+1,2) );



for i=2:2:r - mod(r+1,2)
    
    for j=2:2:c - mod(c+1,2)
       
        tmp = double(upsampled(i-1:i+1, j-1:j+1)) .* up_kernel;
        upsampled(i,j) = uint8(sum(tmp(:)));
        
    end
    
end

up_kernel =[
    0,1,0;
    1,0,1;
    0,1,0;
] .* 0.25 ;

for i=2:r - mod(r+1, 2)
    
    for j=2+mod(i+1,2):2:c - mod(c+1,2)
        
        tmp = double(upsampled(i-1:i+1, j-1:j+1)) .* up_kernel;
        upsampled(i,j) = uint8(sum(tmp(:)));
        
    end
    
end



figure,imshow(upsampled);
figure,imshow(replicated);
err = [immse(original,upsampled), immse(original,replicated)];
imwrite(upsampled,'goldhill-interpolated-removed.jpg');
imwrite(replicated,'goldhill-replicated-removed.jpg');





