% Putting everything together

%Reading Images
im = imread('pf_desk.jpg');
im1 = im2double(rgb2gray(imread('pf_desk.jpg')));
im2 = im2double(imread('pf_scan_scaled.jpg'));
ims = imread('harrypotter.jpg');
ims = imresize(ims,size(im2));
im3 = im2double(rgb2gray(imread('harrypotter.jpg')));
im3scaled = imresize(im3,size(im2));

% Computing Descriptors
[locs1,desc1] = brief(im1);
[locs2,desc2] = brief(im2);
ratio=0.8;

% Computing matches
[matches] = briefMatch(desc1,desc2,ratio);
% Computing bestH, besterror and inliers
[bestH2to1,bestError, inliers] = ransacH2to1(matches,locs1,locs2);

%Warping the image
warp_im = warpH(ims, bestH2to1, size(im));
Final_image = warp_im;
Final_image(Final_image==0) = im(Final_image==0);
figure;
subplot(121);
imshow(im);
subplot(122);
imshow(Final_image);
