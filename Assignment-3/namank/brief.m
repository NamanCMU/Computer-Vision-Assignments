function [locs,desc] = brief(im)
% Putting everything together to compute descriptor of interest points. 

load testpattern.mat
sigma0 = 1;
k = sqrt(2);
levels = [-1 0 1 2 3 4];
th_r = 12;
th_contrast = 0.03;
[locs,GaussianPyramid] = DoGdetector(im,sigma0,k,levels,th_contrast,th_r);
[locs,desc] = computeBrief(im,locs,levels,compareX,compareY);


end

