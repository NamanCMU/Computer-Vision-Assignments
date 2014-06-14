function [locs,GaussianPyramid] = DoGdetector(im,sigma0,k,levels,th_contrast,th_r)
% Combining all the parts into a DOG Detector

[GaussianPyramid] = createGaussianPyramid(im, sigma0, k, levels);
[DoGPyramid, DoG_levels] = createDoGPyramid(GaussianPyramid, levels);
[ PrincipalCurvature ] = computePrincipalCurvature(DoGPyramid);
[ locs ] = getLocalExtrema(DoGPyramid, DoG_levels,PrincipalCurvature,th_contrast,th_r);

end

