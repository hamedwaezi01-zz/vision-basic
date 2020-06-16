function res = get_prediction(im, levels)
[s,ss] = size(im);
res = zeros(levels,s,ss);
prev = double(im);

sz_x = 5;
sz_y = sz_x;
mu_x = 0;
mu_y = mu_x;
x = linspace(-2, 2, sz_x);
y = linspace(-2, 2, sz_y);
kernel = exp( -((x-mu_x).^2+ (y-mu_y)'.^2 )./2 ) ./ (2*pi);
% % % Downsampling
for i=1:levels-1
tmp1 = double(convolve(prev,kernel));
res2 = tmp1(1:2:end, 1:2:end);
tmp2 = prev - resizem(res2,2);
[j,jj] = size(tmp2);
res(i, 1:j,1:jj)= tmp2;
prev = res2;
end
i = i + 1;
[j,jj] = size(prev)
res(i, 1:j,1:jj)= prev;
end