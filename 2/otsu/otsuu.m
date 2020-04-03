% % % http://www.labbookpages.co.uk/software/imgProc/otsuThreshold.html
% Single Threshold
function thresh= otsuu(im)
% im = imread('Camera Man.bmp');
[r,c] = size(im);
bwvar = inf;
thresh = 0;
for t=1:255
    low = double(im(im<t));
    high = double(im(im>=t));
    weightl = sum(low) / (r*c);
    weighth = sum(high) / (r*c);
%     meanl = mean(low);
%     meanh = mean(high);
    varl = var(low);
    varh = var(high);    
    tmp = weightl*varl + weighth*varh;
    if bwvar > tmp
       
        bwvar = tmp;
        thresh = t;
        
    end
end


