% Correlating two matrices 'im' and 'kernel' with padding
function res = convolve(im, kernel)

[s,ss] = size(im);
[sz_x, sz_y] = size(kernel);
% Padding
hx = floor(sz_x/2);
hy = floor(sz_y/2);
im = double(im);
im2 = [im(1:hy,:);im(:,:);im(s-hy+1:s,:);];
im2 = [im2(:,1:hx), im2, im2(:, ss-hx+1:ss)];
res = zeros(s,ss);
for i =1+hy:s+hy
    for j=1+hx:ss+hx
        tmp = im2(i-hy:i+hy, j-hx:j+hx) .* kernel;
        res(i-hy, j-hx) = sum(tmp(:));
    end
end
res = uint8(res);
end



