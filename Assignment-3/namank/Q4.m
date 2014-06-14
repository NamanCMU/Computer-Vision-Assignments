% Plot the Histogram by counting correct number of matches while rotating 
% the second image.

img = imread('chickenbroth_01.jpg');
im = im2double(rgb2gray(img));
load testpattern.mat
load parameters.mat
j=1;

[locs1,desc1] = brief(im);
matches = [];
for angle = 0:10:20
    imrotated = imrotate(im,angle); %Rotating the image.
    [locs2,GaussianPyramid] = DoGdetector(imrotated,sigma0,k,levels,th_contrast,th_r);
    
    for i=1:size(locs2,1)
        if locs2(i,1) > 4 && locs2(i,1) < (size(imrotated,1) - 4) && locs2(i,2) > 4 && locs2(i,2) < (size(imrotated,2) - 4)
            locstemp(j,1) = locs2(i,1);
            locstemp(j,2) = locs2(i,2);
            locstemp(j,3) = locs2(i,3);
            j = j + 1;
        end
    end
    locs2 = locstemp;

    desc2 = zeros(size(locs2,1),size(compareX,1));
    patchsize = [9,9];
    [Pair1x,Pair1y] = ind2sub(patchsize,compareX);
    [Pair2x,Pair2y] = ind2sub(patchsize,compareY);
    [xx1] = [0;Pair1x];
    [yy1] = [0;Pair1y];
    [Theta1, R1] = cart2pol(xx1,yy1);
    Theta1 = Theta1 + angle*pi./180;
    [xx1,yy1] = pol2cart(Theta1,R1);
    [Pair1x] = xx1(2:end);
    [Pair1y] = yy1(2:end);
    [xx2] = [0;Pair2x];
    [yy2] = [0;Pair2y];
    [Theta2, R2] = cart2pol(xx2,yy2);
    Theta2 = Theta2 + angle*pi./180;
    [xx2,yy2] = pol2cart(Theta2,R2);
    [Pair2x] = xx2(2:end);
    [Pair2y] = yy2(2:end);
        
    

    % Choosing the origin of 9x9 patch around the point
    originx = locs2(:,1) - 4;
    originy = locs2(:,2) - 4;
    [GaussianPyramid] = createGaussianPyramid(imrotated, sigma0, k, levels);

    % Computing the descriptors by comparing intensities of corresponding Gaussians 
    for i=1:size(locs2,1)
        lev = locs2(i,3);
        Gauss = GaussianPyramid(:,:,lev);
        correspt1 = [originx(i,1) + Pair1x,originy(i,1) + Pair1y];
        correspt2 = [originx(i,1) + Pair2x,originy(i,1) + Pair2y];  
        desc2(i,:) = diag(imrotated(correspt1(:,1),correspt1(:,2))) > diag(imrotated(correspt2(:,1),correspt2(:,2)));
    end
    ratio = 0.8;
    [matchestemp] = briefMatch(desc1,desc2,ratio);
    matches = [matches;size(matchestemp,1)];
end

% Plotting
matches = matches./max(matches(:,1))
bar(0:10:20,matches);
    
