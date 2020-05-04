% Hight Boost Filter of a grayscale
%   image with coefficient of 'a'
function res = highboost(im, a, sigma)

[s,ss] = size(im);

mask = gaussian_filter(im,sigma);

mask = im - mask;

res = im + a*mask;

end