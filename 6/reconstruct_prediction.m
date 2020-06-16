function res = reconstruct_prediction(ims,levels)
[~,s,ss] = size(ims);
s = ss;
i = ss/(2^(levels-1));
j = i;
f1 = squeeze(ims(levels,1:j,1:j));
% figure,imshow(uint8(f1));
for i=levels-1:-1:1
j = floor(s./2.^(i-1));
f2 = squeeze(ims(i,1:j,1:j));
% new = uint8(zeros(j*2,j*2));
new = resizem(f1,2);
f1 = new + f2;
end
res = f1;

end