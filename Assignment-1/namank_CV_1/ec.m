clear
clc
% Q7 Extra Credit

% Load images and points 
load ecpts.mat
img1 = imread('ec1.jpg');
img2 = imread('ec2.jpg');

p1 = ecpts(1:2,:);
p2 = ecpts(3:4,:);
[H2to1] = computeH_norm(p1,p2);

% Warping Image 2
warp_im1 = warpH(img2,H2to1,[size(img1,1),1440]);

% Making Panorma
[l,m,~] = size(img1);
warp_im1(1:l,1:m,:) = img1(:,:,:);
im_pan = warp_im1(:,1:1440,:);
imwrite(im_pan,'ec_pan.jpg');
imtool(im_pan);
