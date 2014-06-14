% Computing Feature Matches and then plotting them

im1 = im2double(rgb2gray(imread('model_chickenbroth.jpg')));
im2 = im2double(rgb2gray(imread('chickenbroth_01.jpg')));

% Computing descriptors of two images
[locs1,desc1] = brief(im1);
[locs2,desc2] = brief(im2);

ratio = 0.8;
[matches] = briefMatch(desc1,desc2,ratio); % Finding matches
figure;
plotMatches(im1,im2,matches,locs1,locs2); % Plotting the matches. 