function res = localHistogram(kernel,im)
res = zeros(1,256);
sz = size(kernel,1);
for i=1:sz
    % assigning corresponding kernel value
    for j=1:sz
        res(round(im(i,j))+1) = res(round(im(i,j))+1) + kernel( mod(i, sz+1), mod(j, sz+1) );
    end
end
end