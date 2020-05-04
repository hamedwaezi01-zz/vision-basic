function res = writedft2(im,path)
imwrite(mat2gray(log(abs(im)+1)), path);
end