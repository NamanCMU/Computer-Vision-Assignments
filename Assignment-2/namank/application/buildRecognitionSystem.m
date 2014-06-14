clear
clc

load traintest.mat
MatTrs = strrep(imTrs(:),'.jpg','.mat');
toProcess = strcat([cd,'/wordmaps/'],MatTrs);
featureTrs = [];
% Create featureTrs cell with dimension as [K*21,T] where K = No. of visual words
% and T is number of Training images 
for i =1:length(toProcess)
    a = toProcess{i};
    load(a)
    H = getImageFeaturesSPM(3,wordMap,100);
    featureTrs = [featureTrs,H];
end

% save featureTrs.mat
save('featureTrs.mat','featureTrs');
disp('FeaturePts saved');


classTrs = csTrs';


% Create classTrs vector with dimension as [1,T] where T is number of Training images 
load traintest.mat

% save classTrs.mat
save('classTrs.mat','classTrs');
disp('ClassPts saved');

load dictionary.mat

%save vision.mat
save('vision.mat','featureTrs','classTrs','dictionary','filterBank');
disp('Vision saved');
