function [ histInter ] = distanceToSet(wordHist, histograms)

% Find histogram intersection similarity
  histInter = sum(bsxfun(@min,wordHist,histograms));  

% Using Euclidean Distance, Dividing it by 1 so that I dont have
% to change guessImage().
% histInter = 1./sqrt(sum(bsxfun(@minus,wordHist,histograms).^2));

end

