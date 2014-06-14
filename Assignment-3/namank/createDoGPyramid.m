function [DoGPyramid, DoG_levels] = createDoGPyramid(GaussianPyramid, levels)
%In this function, we will be obtaining the DOG Pyramid by subtracting
%successive levels of the Gaussian Pyramid

len = length(levels) - 1;
DoGPyramid = zeros(size(GaussianPyramid,1),size(GaussianPyramid,2),len);
DoG_levels = [];
for i=1:len
    DoGPyramid(:,:,i) = (GaussianPyramid(:,:,i+1) - GaussianPyramid(:,:,i));  % Creating DOG Pyramid
    DoG_levels = [DoG_levels;i]; %Creating DOG levels
end
end
