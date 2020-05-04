function res = idft2(im,s,ss,shift)
[m,n] = size(im);
res = dft1d(dft1d(im,1)',1)' ./ (n*m);
res(1:2:m, 2:2:n) = shift .* res(1:2:m, 2:2:n);
res(2:2:m, 1:2:n) = shift .* res(2:2:m, 1:2:n);
res = real(res(1:s, 1:ss));
end


