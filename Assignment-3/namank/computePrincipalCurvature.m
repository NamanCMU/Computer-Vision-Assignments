function [ PrincipalCurvature ] = computePrincipalCurvature(DoGPyramid)
%Finding the Principal Curvature ration in a local neighborhood of a point

PrincipalCurvature = zeros(size(DoGPyramid,1),size(DoGPyramid,2),size(DoGPyramid,3));
len = size(DoGPyramid,3);

for i=1:len
    [gx,gy] = gradient(DoGPyramid(:,:,i));% Using gradient
    [gxx,gxy] = gradient(gx);
    [gxy,gyy] = gradient(gy);
    PrincipalCurvature(:,:,i) = (gxx + gyy).^2./((gxx.*gyy) - (gxy.*gxy)); % Computing ratio
end
end
