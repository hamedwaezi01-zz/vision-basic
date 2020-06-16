function res = median_filter(im, sz)

[s,ss] = size(im);
% Padding
hx = floor(sz/2);
hy = floor(sz/2);
im = double(im);
im2 = [im(1:hy,:);
       im(:,:);
       im(s-hy+1:s,:);];
im2 = [im2(:,1:hx), im2, im2(:, ss-hx+1:ss)];
res = zeros(s,ss);
for i =1+hy:s+hy
    for j=1+hx:ss+hx
        tmp = im2(i-hy:i+hy, j-hx:j+hx);
        res(i-hy, j-hx) = median(tmp(:));
    end
end
% res = uint8(res);
end



