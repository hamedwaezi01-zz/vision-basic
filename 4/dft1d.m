
function res = dft1d(x, s)

N = size(x, 2);
n = 0:N-1;
k = n';
e = exp((s*2j * pi / N) .* (k * n) );
res = x * e;

end

