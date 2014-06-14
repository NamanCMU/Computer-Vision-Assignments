function [ locs ] = getLocalExtrema(DoGPyramid, DoG_levels,PrincipalCurvature,th_contrast,th_r)
% Finding the location of the local extrema in both scale and space that is
% finding interest points

len = length(DoG_levels);
locs =[];
for i=1:len
     %% Compare all the pixels with the neighbors at same level
     Bmax1 = nlfilter(DoGPyramid(:,:,i),[3 3],@(fun) fun(5)*all(fun(5) >= fun([1 2 3 4 6 7 8 9])));
     Bmin1 = nlfilter(DoGPyramid(:,:,i),[3 3],@(fun) fun(5)*all(fun(5) <= fun([1 2 3 4 6 7 8 9])));
     Bmaxlogical1 = (Bmax1~=0);
     Bminlogical1 = (Bmin1~=0);
     %% Compare at different scales and create a logical matrix and then create the final logical matrix corresponding to max and min extremas
     if i==1
        Bmaxlogical2 = DoGPyramid(:,:,i) > DoGPyramid(:,:,i+1);
        Bminlogical2 = DoGPyramid(:,:,i) < DoGPyramid(:,:,i+1);
     elseif i==len
        Bmaxlogical2 = DoGPyramid(:,:,i) > DoGPyramid(:,:,i-1);
        Bminlogical2 = DoGPyramid(:,:,i) < DoGPyramid(:,:,i-1);
     else   
        Bmaxlogical2 = bsxfun(@and,DoGPyramid(:,:,i) > DoGPyramid(:,:,i+1),DoGPyramid(:,:,i) > DoGPyramid(:,:,i-1));
        Bminlogical2 = bsxfun(@and,DoGPyramid(:,:,i) < DoGPyramid(:,:,i+1),DoGPyramid(:,:,i) < DoGPyramid(:,:,i-1));
     end
     Bscalespacemax = bsxfun(@and,Bmaxlogical1,Bmaxlogical2);
     Bscalespacemin = bsxfun(@and,Bminlogical1,Bminlogical2);     
     %% Then, check threshold (th_r and th_contrast)
     Blogical3 = bsxfun(@and,PrincipalCurvature(:,:,i) < th_r,  abs(DoGPyramid(:,:,i)) > th_contrast);
     
     Blogicalmaxfinal = bsxfun(@and,Bscalespacemax, Blogical3);
     Blogicalminfinal = bsxfun(@and,Bscalespacemin, Blogical3);
     [Rmin,Cmin] = find(Blogicalminfinal==1);
     [Rmax,Cmax] = find(Blogicalmaxfinal==1);
     %% Find locs
     levels = zeros(size(Rmin,1) + size(Rmax,1),1);
     levels(:,1) = DoG_levels(i);
     loctemp1 = [Rmin Cmin;Rmax Cmax];
     locs = [locs;[loctemp1,levels]];       
end

end

