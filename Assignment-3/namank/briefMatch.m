function [matches] = briefMatch(desc1,desc2,ratio)
% Find the matches between descriptors from two images.

matches = [];
[IDS,DATA] = knnsearch(desc2,desc1,'k',2,'Distance','Hamming'); % Using knn search to find two neares neighbors.
ratios = DATA(:,1)./DATA(:,2);
j = 1;

% Finding the matches if ratios is less than ratio
for i=1:size(desc1,1)
    if ratios(i,1) < ratio
         matches(j,1) = i;
         matches(j,2) = IDS(i,1);
         j = j + 1;
     end
end
end


