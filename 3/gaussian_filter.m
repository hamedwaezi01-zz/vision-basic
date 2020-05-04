function res = gaussian_filter(im,sigma)

sz_x = 25;
sz_y = sz_x;
mu_x = 0;
mu_y = mu_x;
half = 2;
x = linspace(- half, half, sz_x);
y = linspace(- half, half, sz_y);
kernel = exp( -((x-mu_x).^2+ (y-mu_y)'.^2 )./(2*sigma^2) ) ./ (2*pi*sigma);
kernel = kernel ./ sum(kernel(:));
res = convolve(im, kernel);

end