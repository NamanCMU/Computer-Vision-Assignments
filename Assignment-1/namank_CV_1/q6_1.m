function [H2to1] = q6_1(img1, img2, pts)
%Q6_1 Warping and Panorma

p1 = pts(1:2,:);
p2 = pts(3:4,:);
[H2to1] = computeH_norm(p1,p2);  % Computing H

% Warping Image 1 and Image 2
warp_im1 = warpH(img2,H2to1,[size(img1,1),3000]);
warp_im2 = warpH(img2,H2to1,[size(img1,1),size(img1,2)]);
warped_image = warp_im1;

% Plotting
figure;
subplot(221);
imshow(warp_im1);
title('Warped Image 1!!');
subplot(222);
imshow(warp_im2);
title('Common part between two images');

% Creating Panorma
[l,m,~] = size(img1);
warp_im1(1:l,1:m,:) = img1(:,:,:);

im_pan = warp_im1(:,1:2850,:);
subplot(223);
imshow(im_pan);
title('Panorma Image!!');

% Saving Images
imwrite(warped_image,'q6_1.jpg');
imwrite(im_pan,'q6_1_pan.jpg');
imwrite(warp_im2,'q6_1_common.jpg');
save('q6_1','H2to1');

end