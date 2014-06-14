% Plot the Histogram by counting correct number of matches while rotating 
% the second image.

img = imread('chickenbroth_01.jpg');
im = im2double(rgb2gray(img));

[locs1,desc1] = brief(im);
matches = [];
for angle = 0:10:360
    imrotated = imrotate(im,angle); %Rotating the image.
    [locs2,desc2] = brief(imrotated);
    ratio = 0.8;
    [matchestemp] = briefMatch(desc1,desc2,ratio);
    matches = [matches;size(matchestemp,1)];
end

% Plotting
matches = matches./max(matches(:,1))
bar(0:10:360,matches);
    
