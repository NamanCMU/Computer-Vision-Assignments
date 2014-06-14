function [moving_image] = SubtractDominantMotion(image1,image2)
% This will run LucasKanadeAffine and will find a logical image with 1 at
% pixels which has motion and 0 elsewhere.

% Converting to uint8
image1 = uint8(image1);
image2 = uint8(image2);

% Running LucasKanadeAffine
M = LucasKanadeAffine(image1,image2);

new_image1 = warpH(image1,M,size(image2)); % warp the image.

image_diff = abs(image2 - new_image1);
image_diff = im2double(image_diff);

%Threshold values
T1 = 0.25;
T2 = 0.15;

moving_image = hysthresh(image_diff, T1, T2);
% Using morphology operation
moving_image = bwmorph(moving_image,'clean');
% Using Dilation operation.
moving_image = imdilate(moving_image,strel('disk',2 ));
imtool(moving_image);
end

function warp_im = warpH(im, H, out_size,fill_value)

if ~exist('fill_value', 'var') || isempty(fill_value)
    fill_value = 0;
end

tform = maketform( 'affine', H'); 
warp_im = imtransform( im, tform, 'bilinear', 'XData', [1 out_size(2)], 'YData', [1 out_size(1)], 'Size', out_size(1:2), 'FillValues', fill_value*ones(size(im,3),1));
end


