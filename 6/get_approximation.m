function res = get_approximation(im, levels)
[s,ss] = size(im);
res = zeros(levels,s/2,ss/2);
prev = double(im);
sz_x = 5;
sz_y = sz_x;
mu_x = 0;
mu_y = mu_x;
x = linspace(-2, 2, sz_x);
y = linspace(-2, 2, sz_y);
kernel = exp( -((x-mu_x).^2+ (y-mu_y)'.^2 )./2 ) ./ (2*pi);

for i=1:levels
new = double(convolve(prev,kernel));
tmp = new(1:2:end, 1:2:end);
[j,jj] = size(tmp);
res(i, 1:j,1:jj)= tmp;
prev = tmp;
end

end