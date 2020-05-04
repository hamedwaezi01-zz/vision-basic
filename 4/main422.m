close all;
clear; clc;

name = 'Lena.bmp';
im = imread(name);
im = rgb2gray(im);
im = double(im);
[s,ss] = size(im);
n = 2^(ceil(log2(s)) + 0 );
m = 2^(ceil(log2(ss))+ 0 );
N = n;
% mask = ones(m,n);
% mask(T*N +1: (1-T)*N -1, T*N +1: (1-T)*N -1)

T = 1/4;
fourier = dft2(im,m,n,1);

fourier(T*N +1: (1-T)*N -1, T*N +1: (1-T)*N -1) = 0;str='a';  %%%% 4.2.2:a
% % fourier(1:T*N+1, 1:T*N+1) = 0;str='i'; %%%% 4.2.2:b:i
% % fourier(1:T*N+1, (1-T)*N:N) = 0;str='ii';  %%%% 4.2.2:b:ii
% % fourier((1-T)*N:N, 1:T*N+1) = 0;str='iii'; %%%% 4.2.2:b:iii
% % fourier((1-T)*N:m, (1-T)*N:n) = 0;str='iv';  %%%% 4.2.2:b:iv

str = 'b';
% new = mag .* exp(1j .* phi);
d = (idft2(fourier,s,ss,1));
% figure,showdft2(fourier);
% figure,imshow(d);
x = uint8(mat2gray(log(abs(fourier)+1)).*255);

% imwrite(uint8(d), ['422/1/lena-',str,'-o',num2str(T),'.bmp']);
% imwrite(x, ['422/1/lena-',str,'-f',num2str(T),'.bmp']);
% imwrite([x,uint8(d)], ['422/2/lena-',str,'-',num2str(T),'.bmp']);



















