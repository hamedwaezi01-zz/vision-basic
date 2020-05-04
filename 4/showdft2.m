function res = showdft2(x)
res = mat2gray(log(abs(x)+1));
res=imshow(res);
end