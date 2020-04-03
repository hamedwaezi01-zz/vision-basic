
function res = localHisteq(im, f)
[s,ss] = size(im);
res = uint8(zeros(s,ss));
for i = 1:s
    for j = 1:ss
        res(i,j) = f(round(im(i,j)) + 1);
    end
end
end