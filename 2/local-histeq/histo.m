function res = histo(im)

res = zeros(1,256);
[s,ss] = size(im);
for i=1:s
  for j=1:ss
    histog(round(im(i,j))+1) = [
      res(round(im(i,j))+1) + 1];
  end
end

end

