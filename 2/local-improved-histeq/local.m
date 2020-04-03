clear all;
close all;
clc;
% % name  : win-size   err-max     err-min     im-size     padding-type
% % 'HE1' : 128x128     0.00005      0.0025      '800x600'     'symmetric'
% % 'HE2' : 256x256     -inf         0.00001     '512x512'     'symmetric;
% % 'HE3' : 256x256     -inf         0.00001     '568x797'     'symmetric'
% % 'HE4' : 256x256     -inf         0.00001     '600x800'     'symmetric'
% ii = 16;
% jj = 16;
data = [1 , 128,     0.00005,     0.0025;
        2,  256,     -inf,         0.00001;
        3,  256,     -inf,         0.00001;
        4,  256,     -inf,         0.00001;
];
name = 'HE4';
which = 4;
% im = imread('Camera Man.bmp');
im = rgb2gray(imread(['HE',num2str(which),'.jpg']));
[s,ss] = size(im);
%%% Local Histogram Equalization
for sz_x=[64,128,256,512]

% size of kernel (Window) and steps
sz_y = sz_x;
step_x = round(sz_x / 4);
step_y = round(sz_y / 4);

% defining kernel
mu_x = 0;
mu_y = mu_x;
half = 2;
x = linspace(- half, half, sz_x);
y = linspace(- half, half, sz_y);
% kernel = exp(-x .^ 2 / (2 * sigma ^ 2))
% kernel = exp( (x.^2 )./2)./sqrt(2*pi);         4.7878e-29 0.1
% kernel = exp(- () )
kernel = exp( -((x-mu_x).^2+ (y-mu_y)'.^2 )./2 ) ./ (2*pi);

% code for adding Padding of the image
padding_x = (sz_x - (ss - floor(ss/step_x) * step_x));
padding_y = ( sz_y - (s - floor(s/step_y) * step_y) );

% im2 = [im,im(:,ss - padding_x:ss)];
% im2 = [im2;im2(s - padding_y:s,:)];

im2 = [im(:,1: ceil(padding_x/2) ), im , im(:,ss - ceil(padding_x)/2:ss) ];
im2 = [ im2(1:ceil(padding_y/2),:)
        im2;
        im2(s - ceil(padding_y/2):s,:)];

% Weight and threshold for 
%    offset of equalization function
weights = zeros(size(im2));
res = zeros(size(im2));
% error values as threshold for setting 
%    offsets of equalizer function
err_max = data(which,3);
err_min = data(which,4);
% l1=0;
number = 1:256;
offf = zeros(19,24,4);
for i=1:step_x:s

    for j=1:step_y:ss
        tmp = im2(i:i+sz_x-1, j:j+sz_y-1);
        % finding normalized histogram of the current 
        %   portion of image according to kernel values
        h = localHistogram(kernel, tmp);
        h = h ./ sum(h);
        min_offset = 1;
        % finding offset for the current portion of
        %   image according to min_offset
%         offf(l1,l2,3) = floor(h(1:128) * number(1:128)');
%         offf(l1,l2,4) = floor(h(128:256) * number(128:256)');
%         offf(l1,l2,4) = h(offf(l1,l2,3)) / 500;
%         min_offset = 1;
%         err_min = h(offf(l1,l2,3)+1);
%         err_min =h(offf(l1,l2,3)) / 100;
%         makhraj = 100000;
%         if err_min == 0
%             min_offset = 128;
%             err_min = h(offf(l1,l2,4)+1) / makhraj ;
%         else
%             min_offset = 1;
%             err_min = h(offf(l1,l2,3)+1) / makhraj ;
%         end
%         
%         if err_max == 0
%             max_offset = 128;
%             err_max = h(offf(l1,l2,3)+1)/ makhraj ;
%         else
%             max_offset = 256;
%             err_max = h(offf(l1,l2,4)+1)/ makhraj ;
%         end
        
        while h(min_offset) < err_min
            min_offset = min_offset + 1;
        end
%         err_max = h(offf(l1,l2,4)+1);
        max_offset = 256;
        while h(max_offset) < err_max
           max_offset = max_offset - 1;
        end
%         offf(l1,l2,1) = min_offset;
%         offf(l1,l2,2) = max_offset;
        
        % calculating function for equalization with respect to offsets
        f = (cumsum(h) .* (max_offset - min_offset)) + (min_offset -1); % (max_offset -1) - (min_offset-1)
        % performing equalization to the window with respect to function
        tmp = localHisteq(tmp,f);
        % preprocessing for future weighted averaging
        tmp = double(tmp) .* kernel;
        % adding the window in the corresponding positions in final image
        res(i:i+sz_x-1, j:j+sz_y-1) = res(i:i+sz_x-1, j:j+sz_y-1) + tmp;
        % adding weights to weights matrix in the corresponding positions
        weights(i:i+sz_x-1, j:j+sz_y-1) = weights(i:i+sz_x-1, j:j+sz_y-1) + kernel;
        
    end
    
end

% performing weighted averaging
%   on the final image
res = res ./ weights;
% res = uint8(res(1:s,1:ss));
% removing paddings from image

res = uint8(res(ceil(padding_y/2)+1 : s+ceil(padding_y/2), ceil(padding_x/2)+1:ss+ceil(padding_x/2)));

% figure,imshow(res);

h = histo(res);
h = h ./ sum(h);
% figure,bar(h);
fig = figure('visible','off');

bar(h);
saveas(fig,['results\HE',num2str(which),'-',num2str(sz_x),'x',num2str(sz_y),'hist.bmp'],'bmp');


imwrite(res, ['results\HE',num2str(which),'-',num2str(sz_x),'x',num2str(sz_y),'.bmp']);
end

% imwrite(res,['lolll-with-offset','.bmp']); % ,num2str(sz)





% t1 = imread('lolll-with-offset.bmp');
% t2 = imread('lolll-without-offset.bmp');
% immse(t1,t2)
% for i=1:sz
%     for j=1:sz
%         histog(round(im(i,j))+1) = histog(round(im(i,j))+1) + kernel( mod(i, sz+1), mod(j, sz+1) );
%     end
% end



% window = round([s(1)/ii, s(2)/jj]);
% hold on;
% im2 = uint8(zeros(s));
% for i=1:ii
%     
%     for j=1:jj
% 
%         tmp = im(window(1)*(i-1) + 1:window(1)*i - mod(s(1),ii), window(2)*(j-1)+1:window(2)*j - mod(s(2),jj));
% %         subplot(ii,jj,(i-1)*ii+j);
% %         imshow(tmp);
%         im2(window(1)*(i-1) + 1:window(1)*i - mod(s(1),ii), window(2)*(j-1)+1:window(2)*j - mod(s(2),jj)) = main2(tmp);
%     end
%     
% end

% hold off;
% figure,imshow(im2);
% figure,imshow(im);
% imwrite(im2,[name,'-local.jpg']);


