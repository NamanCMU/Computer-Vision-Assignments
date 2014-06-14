function [bestH2to1,bestError, inliers] = ransacH2to1(matches,locs1,locs2)
% Using Ransac to get rid of large number of outliers which we were getting
% after using BRIEF.

%Parameters
goodcorr_pre = -1;
N = 500;
Thres_dist = 8;
eeta = 0.01;
minstd = 10000;
inliers = zeros(size(matches,1),1);
totalcorr = size(matches,1);

% Running Iterations
for i=1:N

    randomsamples = sort(randperm(size(matches,1),4))'; %Selecting 4 random points
    pts1 = matches(randomsamples(:,1),1);
    pts2 = matches(randomsamples(:,1),2);

    p1 = [locs1(pts1(:),1),locs1(pts1(:),2)]'
    p2 = [locs2(pts2(:),1),locs2(pts2(:),2)]'
    [H,~] = computeH_norm(p2,p1); % Computing H
  
    pts1test =  matches(:,1);
    p1test = [locs1(pts1test(:,1),1),locs1(pts1test(:,1),2)]';
    p1test3 = [p1test;ones(1,size(p1test,2))];

    pts2test =  matches(:,2);
    p2test = [locs2(pts2test(:,1),1),locs2(pts2test(:,1),2)]';
    p2test3 = [p2test;ones(1,size(p2test,2))];

    % Finding Warped points
    p1testhomo = H*p2test3;
    p1testhomo(1,:) = p1testhomo(1,:)./p1testhomo(3,:);
    p1testhomo(2,:) = p1testhomo(2,:)./p1testhomo(3,:);
    p1testfinal = p1testhomo(1:2,:);

    p2testhomo = inv(H)*p1test3;
    p2testhomo(1,:) = p2testhomo(1,:)./p2testhomo(3,:);
    p2testhomo(2,:) = p2testhomo(2,:)./p2testhomo(3,:);
    p2testfinal = p2testhomo(1:2,:);
 
    % Finding distance between calculated points and actual points
    distance1 = sqrt(sum(bsxfun(@minus,p1testfinal,p1test).^2));
    distance2 = sqrt(sum(bsxfun(@minus,p2testfinal,p2test).^2));
    distance = distance1 + distance2;
    curr_std = std(distance);
    goodcorr = sum(distance<Thres_dist);
    % If number of inliers are more, update H and besterror and inliers
    if (goodcorr > goodcorr_pre || (goodcorr == goodcorr_pre && curr_std < minstd))
        % Finding best error
        mae = sum(distance)./(2*(size(matches,1)));
        bestError = log( 1 + abs(mae));
        goodcorr_pre = goodcorr;
        [~,indx] = find(distance < Thres_dist);
        inliers(indx) = 1; % Inliers
        ratio = goodcorr./totalcorr;
        matchess = matches(indx,:);
        plinear1temp =  matchess(:,1);
        p1linear = [locs1(plinear1temp(:),1),locs1(plinear1temp(:),2)]';
        plinear2temp =  matchess(:,2);
        p2linear = [locs2(plinear2temp(:),1),locs2(plinear2temp(:),2)]';
        pp1(1,:) = p1(2,:);pp1(2,:) = p1(1,:);
        pp2(1,:) = p2(2,:);pp2(2,:) = p2(1,:);
        bestH2to1 = computeH_norm(pp2,pp1); % Updating H
    end
    N = log(eeta)/log(1 - power(ratio,4)); % Updating N
end
end

