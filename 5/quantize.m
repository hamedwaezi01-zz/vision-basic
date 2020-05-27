function res = quantize(im,level)
level = 255 / (level - 1);
res = round(im ./ level);
res = res .* level;
end




