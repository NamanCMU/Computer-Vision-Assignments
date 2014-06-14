function [locs,desc] = computeBrief(im,locs,levels,compareX,compareY)
%This function will compute BRIEF Descriptor for the detected Keypoints

%load parameters.mat
j=1;
locstemp = [];
sigma0 = 1;
k = sqrt(2);
th_r = 12;
th_contrast = 0.03;

% Removing points near the boundary as we will not be able to fit a
% neighborhood window around it
for i=1:size(locs,1)
    if locs(i,1) > 4 && locs(i,1) < (size(im,1) - 4) && locs(i,2) > 4 && locs(i,2) < (size(im,2) - 4)
        locstemp(j,1) = locs(i,1);
        locstemp(j,2) = locs(i,2);
        locstemp(j,3) = locs(i,3);
        j = j + 1;
    end
end
locs = locstemp;

desc = zeros(size(locs,1),size(compareX,1));
patchsize = [9,9];
[Pair1x,Pair1y] = ind2sub(patchsize,compareX);
[Pair2x,Pair2y] = ind2sub(patchsize,compareY);

% Choosing the origin of 9x9 patch around the point
originx = locs(:,1) - 4;
originy = locs(:,2) - 4;
[GaussianPyramid] = createGaussianPyramid(im, sigma0, k, levels);

% Computing the descriptors by comparing intensities of corresponding Gaussians 
for i=1:size(locs,1)
    lev = locs(i,3);
    Gauss = GaussianPyramid(:,:,lev);
    correspt1 = [originx(i,1) + Pair1x,originy(i,1) + Pair1y];
    correspt2 = [originx(i,1) + Pair2x,originy(i,1) + Pair2y];  
    desc(i,:) = diag(Gauss(correspt1(:,1),correspt1(:,2))) > diag(Gauss(correspt2(:,1),correspt2(:,2))) ;
end
end