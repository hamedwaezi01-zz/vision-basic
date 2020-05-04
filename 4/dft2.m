function res = dft2(im,m,n, shift)
[s,ss] = size(im);
res = zeros(m,n);
res(1:s,1:ss) = im;
res(1:2:m, 2:2:n) = shift * res(1:2:m, 2:2:n);
res(2:2:m, 1:2:n) = shift * res(2:2:m, 1:2:n);

res = dft1d(dft1d(res,-1)',-1)';
end