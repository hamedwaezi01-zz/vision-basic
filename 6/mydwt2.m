function [cA,cH,cV,cD] = mydwt2(im)

[s,ss] = size(im);
kernel_cA = [0,0,0;0,1,1;0,1,1]./4;
kernel_cV = [0,0,0;1,0,-1;0,0,0];
kernel_cH = kernel_cV';
kernel_cD = [0,0,0;0,-1,0;0,0,1];

cA = convolve(im,kernel_cA ,2);
cH = convolve(im,kernel_cH ,2);
cV = convolve(im,kernel_cV ,2);
cD = convolve(im,kernel_cD ,2);

end