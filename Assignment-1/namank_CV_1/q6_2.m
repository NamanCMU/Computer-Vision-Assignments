function [H2to1] = q6_2(img1,img2,pts)

%Q6_2 Creating Mosaic Image
p1 = pts(1:2,:);
p2 = pts(3:4,:);
[H2to1] = computeH_norm(p1,p2);

% Finding the vertices of the warped image
v3 = H2to1*[size(img2,2);0;1];v3(:,1) = v3(:,1)./v3(3,1);
v4 = H2to1*[size(img2,2);size(img2,1);1];v4(:,1) = v4(:,1)./v4(3,1);
d = 1280./(v4(1,1)); % Finding Scaling Factor
S = [d 0 0;0 d -d*v3(2,1);0 0 1]; % Transformation Matrix
no_of_rows = v4(2,1) - v3(2,1);

% Warping both the images.
warp_img1 = warpH(img1,S,[round(d*no_of_rows),1280]);
warp_img2 = warpH(img2,S*H2to1,[round(d*no_of_rows),1280]);

% Creating Mosaic Image
warp_img2(warp_img2==0) = warp_img1(warp_img2==0);

im_pan = warp_img2;
imtool(im_pan);
imwrite(im_pan,'q6_2_pan.jpg');
end
