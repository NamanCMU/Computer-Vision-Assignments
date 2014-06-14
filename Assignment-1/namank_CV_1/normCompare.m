clear
clc

%Q5 Sensitivity to Normalization
result_Points = ones(3,1000);
result_normPoints = ones(3,1000);
p = 100*[-2 -1 0 1 2;10 2 1 2 10];
ptest = 100* [0 3];
lent = length(p);
ptest = [ptest';1];  

% Running 1000 times to make 2 result point sets for ptest one for
% un-normalized and other for normalized.
for i=1:1000
    gaussnoise = randn(2,lent);
    pcorrupt = p + gaussnoise;
    H = computeH(p,pcorrupt);
    [Hnorm] = computeH_norm(p,pcorrupt);
    resultpoint = H*ptest;
    resultnormpoint = Hnorm*ptest;
    result_Points(:,i) = resultpoint;
    result_normPoints(:,i) = resultnormpoint;
end
% Converting to Image coordinates from Homogeneous coordinates

result_Points(1,:) = result_Points(1,:)./result_Points(3,:); result_Points(2,:) = result_Points(2,:)./result_Points(3,:);
result_Points(3,:) = result_Points(3,:)./result_Points(3,:);

result_normPoints(1,:) = result_normPoints(1,:)./result_normPoints(3,:); result_normPoints(2,:) = result_normPoints(2,:)./result_normPoints(3,:);
result_normPoints(3,:) = result_normPoints(3,:)./result_normPoints(3,:);

%Plotting Results
figure;
plot(result_normPoints(2,:),result_normPoints(1,:),'bo');
hold on
plot(result_Points(2,:),result_Points(1,:),'ro');
axis equal;

% Standard Deviaitons and Covariance
cov1 = cov(result_Points);
covnorm = cov(result_normPoints);
std1 =  std(sqrt(sum(bsxfun(@minus, mean(result_Points,2), result_Points).^2,2)));
stdnorm =  std(sqrt(sum(bsxfun(@minus, mean(result_normPoints,2), result_normPoints).^2,2)));
ratiostd = std1./stdnorm
